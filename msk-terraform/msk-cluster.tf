resource "aws_vpc" "vpc" {
  cidr_block = "192.168.0.0/22"
}

data "aws_availability_zones" "azs" {
  state = "available"
}

resource "aws_subnet" "subnet_az1" {
  availability_zone = "${data.aws_availability_zones.azs.names[0]}"
  cidr_block        = "192.168.0.0/24"
  vpc_id            = "${aws_vpc.vpc.id}"
}

resource "aws_subnet" "subnet_az2" {
  availability_zone = "${data.aws_availability_zones.azs.names[1]}"
  cidr_block        = "192.168.1.0/24"
  vpc_id            = "${aws_vpc.vpc.id}"
}

resource "aws_subnet" "subnet_az3" {
  availability_zone = "${data.aws_availability_zones.azs.names[2]}"
  cidr_block        = "192.168.2.0/24"
  vpc_id            = "${aws_vpc.vpc.id}"
}

resource "aws_security_group" "sg" {
  vpc_id = "${aws_vpc.vpc.id}"
}

resource "aws_kms_key" "kms" {
  description = "poc"
}

resource "aws_msk_cluster" "msk_poc" {
  cluster_name           = "msk_poc"
  kafka_version          = "2.1.0"
  number_of_broker_nodes = 3

  broker_node_group_info {
    instance_type  = "kafka.m5.large"
    ebs_volume_size = "1000"
    client_subnets = [
      "${aws_subnet.subnet_az1.id}",
      "${aws_subnet.subnet_az2.id}",
      "${aws_subnet.subnet_az3.id}",
    ]
    security_groups = [ "${aws_security_group.sg.id}" ]
  }

  encryption_info {
    encryption_at_rest_kms_key_arn = "${aws_kms_key.kms.arn}"
  }

  tags = {
    Owner = "glimsil"
  }
}

output "zookeeper_connect_string" {
  value = "${aws_msk_cluster.msk_poc.zookeeper_connect_string}"
}

output "bootstrap_brokers" {
  description = "Plaintext connection host:port pairs"
  value       = "${aws_msk_cluster.msk_poc.bootstrap_brokers}"
}

output "bootstrap_brokers_tls" {
  description = "TLS connection host:port pairs"
  value       = "${aws_msk_cluster.msk_poc.bootstrap_brokers_tls}"
}

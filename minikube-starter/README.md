# Minikube starter - how to
First of all you need to have virtualbox installed.


### Removing previous installations

```
    sudo rm -rf /usr/local/bin/kubectl
    minikube delete
    rm -rf ~/.minikube
```
### Installing Kubectl and Minikune
```
    curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/386/kubectl && chmod +x kubectl && sudo mv kubectl /usr/local/bin
    curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/

    minikube start
    kubectl version
```
kubectl and minikube installed (:

### Deploying to minikube 
In this repo we have a `server.js` that is a simple Node.js hello-world server and a Dockerfile.
With that, we can type the following commands:
```
minikube start
eval $(minikube docker-env)
docker build -t hello-node:v1 .
kubectl run hello-node --image=hello-node:v1 --port=8080
kubectl get deployments
kubectl get pods
kubectl expose deployment hello-node --type=LoadBalancer
kubectl get services
minikube service hello-node
kubectl delete service hello-node
kubectl delete deployment hello-node
minikube stop
```

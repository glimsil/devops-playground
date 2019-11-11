package main

import (
	"github.com/gorilla/mux"
	"net/http"
)

func helloWorld(response http.ResponseWriter, request *http.Request){
	response.Header().Set("Content-Type", "application/json")
	response.Write([]byte("{\"hello\":\"world\"}"))
}

func main() {
	routes := mux.NewRouter()
	calcApi := routes.PathPrefix("/hello").Subrouter()
	calcApi.HandleFunc("/world", helloWorld)
	http.ListenAndServe(":5000", routes)
} 

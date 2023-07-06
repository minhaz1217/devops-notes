package main
import (
	"fmt"
	"log"
	"net/http"
)
func main() {
	fmt.Println("App Starting...")
	http.HandleFunc("/", handler)
	log.Fatal(http.ListenAndServe(":3000", nil))
}
func handler(w http.ResponseWriter, r *http.Request) {
	simpleOutput := fmt.Sprintf("Got hit from: %s", r.URL.Path[1:])
	fmt.Println(simpleOutput)
	fmt.Fprintf(w, simpleOutput)
}

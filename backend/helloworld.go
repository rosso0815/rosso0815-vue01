package main

// [START import]
import (
	"fmt"
	"log"
	"net/http"
	"os"

	"github.com/gobuffalo/packr/v2"
)


func main() {

	box := packr.New("someBoxName", "./templates")

	http.Handle("/", http.FileServer(box))

	port := os.Getenv("PORT")
	if port == "" {
		port = "8081"
		log.Printf("Defaulting to port %s", port)
	}

	log.Printf("Listening on port %s", port)
	if err := http.ListenAndServe(":"+port, nil); err != nil {
		log.Fatal(err)
	}
}

func indexHandler(w http.ResponseWriter, r *http.Request) {
	if r.URL.Path != "/" {
		http.NotFound(w, r)
		return
	}
	fmt.Fprint(w, "Hello, World!")
}



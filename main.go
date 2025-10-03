package main

import (
	"log"
	"net/http"

	"github.com/eif-courses/go-web/templates"
	"github.com/go-chi/chi/v5"
)

func main() {
	r := chi.NewRouter()

	// Serve static files from assets folder
	r.Handle("/assets/*", http.StripPrefix("/assets/", http.FileServer(http.Dir("./assets"))))

	// Your route
	r.Get("/", func(w http.ResponseWriter, r *http.Request) {
		err := templates.ButtonPage().Render(r.Context(), w)
		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			log.Printf("Error rendering template: %v", err)
		}
	})

	log.Println("🚀 Server starting on http://localhost:8080")

	// This is the key fix - check for errors!
	if err := http.ListenAndServe("localhost:8080", r); err != nil {
		log.Fatalf("❌ Server failed to start: %v", err)
	}
}

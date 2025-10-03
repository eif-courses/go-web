package main

import (
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
		templates.ButtonPage().Render(r.Context(), w)
	})

	http.ListenAndServe("localhost:8080", r)
}

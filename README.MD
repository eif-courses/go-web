# 🚀 Go Webstack

A modern **full-stack Go web starter kit** powered by **Chi, Zap, SQLC, Goose, Air, Templ, Task, SCS, UUID, and PGX**.

This stack provides:
- 🔥 Hot reload with [Air](https://github.com/air-verse/air)
- 🛠️ Task runner with [Task](https://taskfile.dev)
- 🗄️ SQL code generation with [SQLC](https://sqlc.dev)
- 🐘 Database migrations with [Goose](https://github.com/pressly/goose)
- 🌱 Environment management with [Godotenv](https://github.com/joho/godotenv)
- ⚡ Structured logging with [Zap](https://github.com/uber-go/zap)
- 🌐 HTTP routing with [Chi](https://github.com/go-chi/chi)
- 🎨 UI components with [Templ](https://templ.guide) + [TemplUI](https://templui.io)
- 🔑 Server-side sessions with [SCS](https://github.com/alexedwards/scs)
- 🆔 UUID generation with [google/uuid](https://github.com/google/uuid)
- 🐘 PostgreSQL advanced types with [pgx/pgtype](https://pkg.go.dev/github.com/jackc/pgx/v5/pgtype)

---

## 📦 Prerequisites

Make sure you have:
- [Go](https://go.dev/doc/install) (v1.22+ recommended)
- [Git](https://git-scm.com/)
- A supported database (e.g. PostgreSQL or MySQL)

---

## 🔧 Installation

Install all required CLI tools and libraries:

```bash
# --- Development Tools ---
# SQL Code Generator
go install github.com/sqlc-dev/sqlc/cmd/sqlc@latest

# Task runner (modern Makefile alternative)
go install github.com/go-task/task/v3/cmd/task@latest

# Live reloading for Go apps
go install github.com/air-verse/air@latest

# Environment variable loader
go install github.com/joho/godotenv/cmd/godotenv@latest

# Database migration tool
go install github.com/pressly/goose/v3/cmd/goose@latest

# --- Libraries ---
# Structured logging
go get -u go.uber.org/zap

# HTTP Router
go get -u github.com/go-chi/chi/v5

# Session management (SCS)
go get github.com/alexedwards/scs/v2

# UUID generation
go get github.com/google/uuid

# PostgreSQL advanced types
go get github.com/jackc/pgx/v5/pgtype


# Tailwind libs 
go get github.com/Oudwins/tailwind-merge-go

# --- UI Tools ---
# Templ CLI (type-safe HTML in Go)
go install github.com/a-h/templ/cmd/templ@latest
go get github.com/a-h/templ

# TemplUI CLI (UI components library for Templ)
go install github.com/templui/templui/cmd/templui@latest

```
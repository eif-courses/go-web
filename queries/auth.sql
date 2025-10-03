-- name: CreateUser :one
-- Inserts a new user and returns safe fields (without password hash)
INSERT INTO users (email, password_hash, first_name, last_name, role)
VALUES ($1, $2, $3, $4, $5)
RETURNING id, email, first_name, last_name, role, is_active, created_at, updated_at, last_login_at;

-- name: GetUserByID :one
-- Retrieves a user by ID (excluding password hash)
SELECT id, email, first_name, last_name, role, is_active, created_at, updated_at, last_login_at
FROM users
WHERE id = $1;

-- name: GetUserByEmail :one
-- Retrieves a user by email (excluding password hash)
SELECT id, email, first_name, last_name, role, is_active, created_at, updated_at, last_login_at
FROM users
WHERE email = $1;

-- name: GetAllUsers :many
-- Retrieves all users (excluding password hash)
SELECT id, email, first_name, last_name, role, is_active, created_at, updated_at, last_login_at
FROM users;

-- name: DeactivateUser :exec
-- Deactivates a user (no return)
UPDATE users
SET is_active = false
WHERE id = $1;

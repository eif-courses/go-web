-- +goose Up
-- +goose StatementBegin

-- Enable UUID generation
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Create ENUM for roles
DO $$
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'user_role') THEN
            CREATE TYPE user_role AS ENUM ('user', 'admin', 'moderator');
        END IF;
    END
$$;

-- Users table
CREATE TABLE IF NOT EXISTS users (
                                     id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
                                     email VARCHAR(255) UNIQUE NOT NULL,
                                     password_hash TEXT,
                                     first_name VARCHAR(100) NOT NULL,
                                     last_name VARCHAR(100) NOT NULL,
                                     role user_role DEFAULT 'user' NOT NULL,
                                     is_active BOOLEAN DEFAULT true NOT NULL,
                                     created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL,
                                     updated_at TIMESTAMPTZ DEFAULT NOW() NOT NULL,
                                     last_login_at TIMESTAMPTZ
);

-- Indexes for users
CREATE INDEX IF NOT EXISTS idx_users_role ON users(role);
CREATE INDEX IF NOT EXISTS idx_users_is_active ON users(is_active);

-- Trigger function for updated_at
CREATE OR REPLACE FUNCTION update_updated_at_column()
    RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Attach trigger to users table
DROP TRIGGER IF EXISTS update_users_updated_at ON users;
CREATE TRIGGER update_users_updated_at
    BEFORE UPDATE ON users
    FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

-- OAuth accounts table
CREATE TABLE IF NOT EXISTS oauth_accounts (
                                              id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
                                              user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
                                              provider VARCHAR(50) NOT NULL,
                                              provider_user_id VARCHAR(255) NOT NULL,
                                              access_token TEXT,
                                              refresh_token TEXT,               -- optional, store only if you need offline access
                                              token_expires_at TIMESTAMPTZ,
                                              created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL,
                                              updated_at TIMESTAMPTZ DEFAULT NOW() NOT NULL,
                                              UNIQUE(user_id, provider),
                                              UNIQUE(provider, provider_user_id)
);

-- Sessions table (SCS)
CREATE TABLE IF NOT EXISTS sessions (
                                        token TEXT PRIMARY KEY,
                                        data BYTEA NOT NULL,
                                        expiry TIMESTAMPTZ NOT NULL
);

-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin

-- Drop triggers and functions
DROP TRIGGER IF EXISTS update_users_updated_at ON users;
DROP FUNCTION IF EXISTS update_updated_at_column();

-- Drop tables
DROP TABLE IF EXISTS sessions;
DROP TABLE IF EXISTS oauth_accounts;
DROP TABLE IF EXISTS users;

-- Drop ENUM type
DROP TYPE IF EXISTS user_role;

-- +goose StatementEnd

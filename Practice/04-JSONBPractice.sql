CREATE TABLE customers(
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    profile JSONB DEFAULT '{}'::JSONB,
    created_at TIMESTAMP DEFAULT NOw()
);

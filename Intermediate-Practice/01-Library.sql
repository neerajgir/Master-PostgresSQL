-- Active: 1785411209906@@127.0.0.1@5432@intermediate_practice
CREATE TABLE books (
    id SERIAL PRIMARY KEY,    
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    price NUMERIC(5, 2) CHECK (price > 0),
    stock INT CHECK (stock >= 0),
    metadata JSONB DEFAULT '{}'::JSONB
);


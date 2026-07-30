-- CREATE DATABASE postgressql_basics;

CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    age INT NOT NULL CHECK(age>=18),
    created_at TIMESTAMP DEFAULT NOW()
)
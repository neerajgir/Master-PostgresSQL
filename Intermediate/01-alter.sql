-- Active: 1785411209906@@127.0.0.1@5432@intermediate
CREATE TABLE movies (
    movie_id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    release_year INT 
);
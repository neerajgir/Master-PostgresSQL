CREATE TABLE directors (
    director_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    birth_year INTEGER,
    nationality VARCHAR(50)
);

CREATE TABLE director_movies (
    movie_id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    director_id INTEGER NOT NULL,  -- No UNIQUE here, allows multiple movies per director
    release_year INTEGER,
    budget DECIMAL(12, 2),
    FOREIGN KEY (director_id) REFERENCES directors(director_id) ON DELETE RESTRICT
);

-- Insert directors
INSERT INTO directors (name, birth_year, nationality) VALUES
('Christopher Nolan', 1970, 'British-American'),
('Greta Gerwig', 1983, 'American'),
('Denis Villeneuve', 1967, 'Canadian');

-- Insert movies (multiple movies per director)
INSERT INTO director_movies (title, director_id, release_year, budget) VALUES
('Inception', 1, 2010, 160000000),
('Interstellar', 1, 2014, 165000000),
('Dunkirk', 1, 2017, 100000000),
('Lady Bird', 2, 2017, 10000000),
('Little Women', 2, 2019, 40000000),
('Arrival', 3, 2016, 47000000),
('Blade Runner 2049', 3, 2017, 150000000);


-- View all directors
SELECT * FROM directors;

-- View all movies
SELECT * FROM director_movies;

-- Count movies per director
SELECT 
    director_id,
    COUNT(*) AS movie_count
FROM director_movies
GROUP BY director_id;
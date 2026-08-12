-- First main table
CREATE TABLE actors (
    actor_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    birth_year INTEGER,
    country VARCHAR(50)
);

-- Second main table
CREATE TABLE films (
    film_id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    release_year INTEGER,
    genre VARCHAR(50)
);

-- Junction table (bridges the many-to-many relationship)
CREATE TABLE film_cast (
    cast_id SERIAL PRIMARY KEY,
    film_id INTEGER NOT NULL,
    actor_id INTEGER NOT NULL,
    character_name VARCHAR(100),
    role_type VARCHAR(20) DEFAULT 'supporting',
    FOREIGN KEY (film_id) REFERENCES films(film_id) ON DELETE CASCADE,
    FOREIGN KEY (actor_id) REFERENCES actors(actor_id) ON DELETE CASCADE,
    UNIQUE(film_id, actor_id)  -- Prevents same actor being cast twice in same film
);

-- Insert actors
INSERT INTO actors (name, birth_year, country) VALUES
('Leonardo DiCaprio', 1974, 'USA'),
('Marion Cotillard', 1975, 'France'),
('Tom Hardy', 1977, 'UK'),
('Anne Hathaway', 1982, 'USA'),
('Matthew McConaughey', 1969, 'USA');

-- Insert films
INSERT INTO films (title, release_year, genre) VALUES
('Inception', 2010, 'Sci-Fi'),
('The Dark Knight Rises', 2012, 'Action'),
('Interstellar', 2014, 'Sci-Fi'),
('Dunkirk', 2017, 'War');

-- Create the many-to-many relationships through the junction table
INSERT INTO film_cast (film_id, actor_id, character_name, role_type) VALUES
-- Inception has 3 actors
(1, 1, 'Dom Cobb', 'lead'),
(1, 2, 'Mal Cobb', 'supporting'),
(1, 3, 'Eames', 'supporting'),
-- The Dark Knight Rises has 2 actors
(2, 3, 'Bane', 'lead'),
(2, 4, 'Catwoman', 'lead'),
-- Interstellar has 2 actors
(3, 4, 'Brand', 'supporting'),
(3, 5, 'Cooper', 'lead'),
-- Dunkirk has 1 actor
(4, 3, 'Farrier', 'supporting');

-- View all actors
SELECT * FROM actors;

-- View all films
SELECT * FROM films;

-- View all casting relationships
SELECT * FROM film_cast;

-- Find how many films each actor has
SELECT 
    actor_id,
    COUNT(*) AS film_count
FROM film_cast
GROUP BY actor_id
ORDER BY film_count DESC;

-- Find how many actors each film has
SELECT 
    film_id,
    COUNT(*) AS actor_count
FROM film_cast
GROUP BY film_id
ORDER BY actor_count DESC;
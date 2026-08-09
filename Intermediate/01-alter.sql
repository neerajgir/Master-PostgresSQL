-- Active: 1785411209906@@127.0.0.1@5432@intermediate
CREATE TABLE movies (
    movie_id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    release_year INT 
);

ALTER TABLE movies ADD COLUMN director VARCHAR(100);

ALTER TABLE movies
ADD COLUMN budget DECIMAL(12, 2),
ADD COLUMN box_office DECIMAL(12, 2);

ALTER TABLE movies
ADD COLUMN rating VARCHAR(10) DEFAULT 'PG-13';

ALTER TABLE movies
ADD COLUMN duration_minutes INTEGER NOT NULL DEFAULT 120;


ALTER TABLE movies DROP COLUMN rating;

ALTER TABLE movies
DROP COLUMN box_office,
DROP COLUMN duration_minutes;

ALTER TABLE movies
DROP COLUMN director CASCADE;

ALTER TABLE movies RENAME COLUMN title TO movie_title;

ALTER TABLE movies ALTER COLUMN release_year TYPE SMALLINT;

-- Change with USING clause for complex conversions
ALTER TABLE movies
ALTER COLUMN rating TYPE VARCHAR(20)
USING rating::VARCHAR(20);

-- Change column to allow more precision
ALTER TABLE movies
ALTER COLUMN release_year TYPE NUMERIC(4, 0);
-- Set a default value
ALTER TABLE movies
ALTER COLUMN rating SET DEFAULT 'Not Rated';

-- Drop default value
ALTER TABLE movies
ALTER COLUMN rating DROP DEFAULT;

-- Set default with expression
ALTER TABLE movies
ADD COLUMN added_date DATE DEFAULT CURRENT_DATE;

-- Drop and reset default
ALTER TABLE movies
ALTER COLUMN added_date DROP DEFAULT;

ALTER TABLE movies
ALTER COLUMN added_date SET DEFAULT NOW();

-- Add NOT NULL constraint (ensure no existing NULL values first)
ALTER TABLE movies
ALTER COLUMN movie_title SET NOT NULL;

-- Drop NOT NULL constraint
ALTER TABLE movies
ALTER COLUMN rating DROP NOT NULL;

-- Example workflow: handle existing NULLs before adding constraint
UPDATE movies SET director = 'Unknown' WHERE director IS NULL;

ALTER TABLE movies
ALTER COLUMN director SET NOT NULL;

-- Set default for "unknown" and make NOT NULL
ALTER TABLE movies
ALTER COLUMN director SET DEFAULT 'Unknown';

ALTER TABLE movies
ALTER COLUMN director SET NOT NULL;
SELECT * FROM movies;
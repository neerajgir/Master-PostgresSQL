-- Create sample data
CREATE TABLE viewer_activity (
    activity_id SERIAL PRIMARY KEY,
    user_id INTEGER,
    movie_id INTEGER,
    watch_percentage INTEGER,
    watched_date DATE
);

INSERT INTO viewer_activity (user_id, movie_id, watch_percentage, watched_date) VALUES
(1, 101, 100, '2025-01-01'),
(2, 102, 45, '2025-01-02'),
(3, 103, 75, '2025-01-02'),
(4, 104, 20, '2025-01-03'),
(5, 105, 90, '2025-01-03');

SELECT activity_id, user_id, watch_percentage,
CASE 
    WHEN watch_percentage >= 90 THEN 'Completed'
    WHEN watch_percentage >= 50 THEN 'Partial'
    WHEN watch_percentage >= 20 THEN 'Started'
    ELSE 'Barely Watches'
END AS viewing_status 
FROM viewer_activity;

SELECT * FROM viewer_activity;

-- CASE in SELECT with Multiple Conditions
-- Create movies table with ratings
CREATE TABLE platform_movies (
    movie_id SERIAL PRIMARY KEY,
    title VARCHAR(200),
    genre VARCHAR(50),
    rating DECIMAL(3, 1),
    release_year INTEGER,
    content_rating VARCHAR(10)
);

INSERT INTO platform_movies (title, genre, rating, release_year, content_rating) VALUES
('Stellar Voyage', 'Sci-Fi', 8.7, 2023, 'PG-13'),
('Dark Alley', 'Thriller', 7.2, 2022, 'R'),
('Laugh Factory', 'Comedy', 6.5, 2024, 'PG'),
('Epic Quest', 'Fantasy', 9.1, 2023, 'PG-13'),
('True Crime Story', 'Documentary', 8.0, 2024, 'R');


-- Complex CASE with multiple conditions
SELECT 
    title,
    rating,
    content_rating,
    CASE 
        WHEN rating >= 9.0 THEN 'Must Watch'
        WHEN rating >= 8.0 AND content_rating IN ('PG', 'PG-13') THEN 'Family Friendly Hit'
        WHEN rating >= 7.0 THEN 'Worth Watching'
        WHEN rating >= 6.0 THEN 'Average'
        ELSE 'Skip'
    END AS recommendation,
    CASE 
        WHEN release_year >= 2024 THEN 'New Release'
        WHEN release_year >= 2022 THEN 'Recent'
        ELSE 'Catalog'
    END AS recency
FROM platform_movies;

-- Find movies based on conditional criteria
SELECT 
    title,
    genre,
    rating
FROM platform_movies
WHERE 
    CASE 
        WHEN genre = 'Documentary' THEN rating >= 7.5
        WHEN genre = 'Comedy' THEN rating >= 6.0
        ELSE rating >= 8.0
    END;

    -- Custom sorting logic
SELECT 
    title,
    genre,
    rating
FROM platform_movies
ORDER BY 
    CASE 
        WHEN genre = 'Fantasy' THEN 1
        WHEN genre = 'Sci-Fi' THEN 2
        WHEN genre = 'Thriller' THEN 3
        ELSE 4
    END,
    rating DESC;

-- Count movies by category
SELECT 
    COUNT(*) AS total_movies,
    COUNT(CASE WHEN rating >= 8.0 THEN 1 END) AS highly_rated,
    COUNT(CASE WHEN rating < 7.0 THEN 1 END) AS low_rated,
    COUNT(CASE WHEN content_rating = 'R' THEN 1 END) AS mature_content
FROM platform_movies;

-- Calculate average rating by content category
SELECT 
    content_rating,
    AVG(CASE WHEN genre = 'Sci-Fi' THEN rating END) AS avg_scifi_rating,
    AVG(CASE WHEN genre = 'Comedy' THEN rating END) AS avg_comedy_rating,
    AVG(rating) AS overall_avg
FROM platform_movies
GROUP BY content_rating;


SELECT * FROM platform_movies;
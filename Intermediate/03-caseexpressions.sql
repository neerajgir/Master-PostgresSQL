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


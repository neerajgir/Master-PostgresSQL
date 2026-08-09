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

SELECT * FROM viewer_activity;
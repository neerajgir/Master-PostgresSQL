-- Create sample data
CREATE TABLE viewer_activity (
    activity_id SERIAL PRIMARY KEY,
    user_id INTEGER,
    movie_id INTEGER,
    watch_percentage INTEGER,
    watched_date DATE
);


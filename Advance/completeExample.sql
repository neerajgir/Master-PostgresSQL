-- Users (main table)
CREATE TABLE platform_users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- One-to-One: User Profile (each user has ONE profile)
CREATE TABLE user_profiles (
    profile_id SERIAL PRIMARY KEY,
    user_id INTEGER UNIQUE NOT NULL,  -- UNIQUE makes it one-to-one
    full_name VARCHAR(100),
    date_of_birth DATE,
    bio TEXT,
    FOREIGN KEY (user_id) REFERENCES platform_users(user_id) ON DELETE CASCADE
);

-- One-to-Many: User Watch History (each user has MANY watch records)
CREATE TABLE watch_history (
    history_id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,  -- No UNIQUE, allows multiple records per user
    content_title VARCHAR(200),
    watched_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    completion_percentage INTEGER,
    FOREIGN KEY (user_id) REFERENCES platform_users(user_id) ON DELETE CASCADE
);

-- Many-to-Many Setup: Users and Genres (users like MANY genres, genres liked by MANY users)
CREATE TABLE genres (
    genre_id SERIAL PRIMARY KEY,
    genre_name VARCHAR(50) UNIQUE NOT NULL
);

-- Junction table for many-to-many
CREATE TABLE user_genre_preferences (
    preference_id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    genre_id INTEGER NOT NULL,
    preference_level INTEGER CHECK (preference_level BETWEEN 1 AND 10),
    FOREIGN KEY (user_id) REFERENCES platform_users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (genre_id) REFERENCES genres(genre_id) ON DELETE CASCADE,
    UNIQUE(user_id, genre_id)  -- Each user can rate each genre only once
);

-- Insert sample data
INSERT INTO platform_users (username, email) VALUES
('movie_buff', 'buff@example.com'),
('series_fan', 'fan@example.com');

INSERT INTO user_profiles (user_id, full_name, date_of_birth) VALUES
(1, 'Alex Johnson', '1990-05-15'),
(2, 'Sam Williams', '1985-08-22');

INSERT INTO watch_history (user_id, content_title, completion_percentage) VALUES
(1, 'Stellar Voyage', 100),
(1, 'Epic Quest', 67),
(1, 'Dark Alley', 45),
(2, 'True Crime Story', 100),
(2, 'Laugh Factory', 80);

INSERT INTO genres (genre_name) VALUES
('Sci-Fi'), ('Fantasy'), ('Thriller'), ('Documentary'), ('Comedy');

INSERT INTO user_genre_preferences (user_id, genre_id, preference_level) VALUES
(1, 1, 9),  -- movie_buff loves Sci-Fi (9/10)
(1, 2, 8),  -- movie_buff likes Fantasy (8/10)
(1, 3, 6),  -- movie_buff neutral on Thriller (6/10)
(2, 3, 9),  -- series_fan loves Thriller (9/10)
(2, 4, 7),  -- series_fan likes Documentary (7/10)
(2, 5, 8);  -- series_fan likes Comedy (8/10)

-- View all data
SELECT * FROM platform_users;
SELECT * FROM user_profiles;
SELECT * FROM watch_history;
SELECT * FROM genres;
SELECT * FROM user_genre_preferences;

-- Count watch history per user
SELECT 
    user_id,
    COUNT(*) AS total_watched,
    AVG(completion_percentage) AS avg_completion
FROM watch_history
GROUP BY user_id;

-- Count genre preferences per user
SELECT 
    user_id,
    COUNT(*) AS genres_rated,
    AVG(preference_level) AS avg_preference
FROM user_genre_preferences
GROUP BY user_id;
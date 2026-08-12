-- Single column primary key (most common)
CREATE TABLE streaming_platforms (
    platform_id SERIAL PRIMARY KEY,  -- Auto-incrementing primary key
    platform_name VARCHAR(50) NOT NULL,
    founded_year INTEGER
);

INSERT INTO streaming_platforms (platform_name, founded_year) VALUES
('StreamFlix', 2010),
('WatchNow', 2015),
('VideoHub', 2018);

SELECT * FROM streaming_platforms;

-- Composite primary key (multiple columns together form the key)
CREATE TABLE subscription_history (
    user_id INTEGER,
    plan_change_date DATE,
    new_plan VARCHAR(30),
    PRIMARY KEY (user_id, plan_change_date)  -- Both columns together are unique
);

INSERT INTO subscription_history VALUES
(1, '2024-01-15', 'Basic'),
(1, '2024-06-20', 'Premium'),  -- Same user, different date (allowed)
(2, '2024-01-15', 'Standard'); -- Different user, same date (allowed)
-- (1, '2024-01-15', 'Pro') would fail - duplicate composite key

SELECT * FROM subscription_history;

-- Adding primary key to existing table
CREATE TABLE content_ratings (
    rating_code VARCHAR(10),
    description TEXT
);

-- Add primary key constraint after table creation
ALTER TABLE content_ratings
ADD PRIMARY KEY (rating_code);

INSERT INTO content_ratings VALUES
('G', 'General Audiences'),
('PG', 'Parental Guidance'),
('PG-13', 'Parents Strongly Cautioned'),
('R', 'Restricted');

SELECT * FROM content_ratings;
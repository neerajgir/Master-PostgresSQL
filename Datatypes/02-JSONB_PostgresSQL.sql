-- CREATE TABLE users (
--     id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
--     name VARCHAR(255) NOT NULL ,
--     email VARCHAR(255) NOT NULL UNIQUE,
--     preferences JSONB NOT NULL,
--     created_at TIMESTAMP DEFAULT NOw()
-- );


-- INSERT INTO users (
--     name,
--     email,
--     preferences
-- )
-- VALUES (
--     'Adi Gir',
--     'adigir@gmail.com',
--     '{
--         "theme": "light",
--         "language": "sin-pk",
--         "notification": true
--     }'
-- ),
-- (
--     'Paras Gir',
--     'parasgir@gmail.com',
--     '{
--         "theme": "dark",
--         "language": "urdu-pk",
--         "notification": true
--     }'
-- );

-- SELECT * FROM users;

SELECT name, preferences FROM users;
-- SELECT name, preferences->>'theme' AS theme FROM users;
-- SELECT name AS username, preferences->>'theme' AS theme FROM users;
SELECT name AS username, preferences->>'theme' AS theme, preferences->>'language' AS user_language FROM users;


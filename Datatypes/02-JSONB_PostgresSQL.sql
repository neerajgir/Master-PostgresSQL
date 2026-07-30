-- CREATE TABLE users (
--     id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
--     name VARCHAR(255) NOT NULL ,
--     email VARCHAR(255) NOT NULL UNIQUE,
--     preferences JSONB NOT NULL,
--     created_at TIMESTAMP DEFAULT NOw()
-- );


INSERT INTO users (
    name,
    email,
    preferences
)
VALUES (
    'Adi Gir',
    'adigir@gmail.com',
    '{
        "theme": "light",
        "language": "sin-pk",
        "notification": true
    }'
),
(
    'Paras Gir',
    'parasgir@gmail.com',
    '{
        "theme": "dark",
        "language": "urdu-pk",
        "notification": true
    }'
);

SELECT * FROM users;

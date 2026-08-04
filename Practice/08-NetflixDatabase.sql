-- CREATE TABLE Movies (
--     id SERIAL PRIMARY KEY,
--     title VARCHAR(100) NOT NULL,
--     release_year DATE NOT NULL DEFAULT CURRENT_DATE,
--     rating BIGINT DEFAULT 0,
--     is_series BOOLEAN DEFAULT true,
--     details JSONB DEFAULT '{}'::JSONB
-- );

INSERT INTO Movies (
    title,
    release_year,
    rating,
    is_series,
    details
)
VALUES(
    'Edge of Tomorrow',
    '2014-06-06',
    7.9,
    FALSE,
    '{
    "genres":["Action","Sci-Fi"],
     "cast":[
        "Tom Cruise",
        "Emily Blunt"
    ],
    "duration":"2h 15m"
    }'
);

SELECT * FROM Movies;

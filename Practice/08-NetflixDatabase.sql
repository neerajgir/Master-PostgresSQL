CREATE TABLE Movies (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    release_year DATE NOT NULL DEFAULT CURRENT_DATE,
    rating BIGINT DEFAULT 0,
    is_series BOOLEAN DEFAULT true,
    details JSONB DEFAULT '{}'::JSONB
);

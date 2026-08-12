CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50),
    email VARCHAR(150),
    age INT,
    created_at TIMESTAMP
);

ALTER TABLE users ALTER COLUMN username SET NOT NULL;

ALTER TABLE users ADD CONSTRAINT users_email_unique UNIQUE (email);
ALTER TABLE users ADD CONSTRAINT users_age_check CHECK(age >= 13);

ALTER TABLE users ALTER COLUMN created_at SET DEFAULT NOW();

ALTER TABLE users RENAME COLUMN username TO full_name;

ALTER TABLE users ADD COLUMN country VARCHAR(100) DEFAULT 'Pakistan';

SELECT * FROM users;

CREATE TABLE orderss (
    id SERIAL PRIMARY KEY,
    user_id INT,
    amount NUMERIC(10, 2),
    status VARCHAR(30),
    created_at TIMESTAMP
);



CREATE TABLE productss (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    price NUMERIC(10, 2),
    stock INT
);
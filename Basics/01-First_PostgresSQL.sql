-- CREATE DATABASE postgressql_basics;

-- CREATE TABLE student (
--     id SERIAL PRIMARY KEY,
--     name TEXT NOT NULL,
--     email TEXT NOT NULL UNIQUE,
--     age INT NOT NULL CHECK(age>=18),
--     created_at TIMESTAMP DEFAULT NOW()
-- );

-- SELECT * FROM student;

-- INSERT INTO students (
--     name,
--     email,
--     age
-- )
-- VALUES (
--     'Paras',
--     'paras@gmail.com',
--     '19'
-- )

-- SELECT * FROM student;

-- DROP TABLE student;
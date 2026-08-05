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
-- SELECT name, email FROM student;

-- Update 
-- UPDATE student SET age = 20 WHERE id = 1;

-- Delete
-- DELETE FROM student WHERE id = 1;

-- DROP TABLE student;
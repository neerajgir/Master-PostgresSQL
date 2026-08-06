-- CREATE TABLE course_enrollment (
--     enrollment_id SERIAL PRIMARY KEY,
--     student_name VARCHAR(50) NOT NULL,
--     email VARCHAR(100) UNIQUE NOT NULL,
--     course_name VARCHAR(50) NOT NULL,
--     level VARCHAR(20),
--     price NUMERIC(8,2) CHECK (price > 0),
--     enrolled_on DATE DEFAULT CURRENT_DATE,
--     completion_status BOOLEAN DEFAULT FALSE,
--     rating INT CHECK (rating BETWEEN 1 AND 5),
--     course_meta JSONB,
--     skills TEXT[]
-- );

-- INSERT INTO course_enrollment (student_name, email, course_name, level, price, enrolled_on, completion_status, rating, course_meta, skills) VALUES
-- ('Rohan Malhotra', 'rohan.malhotra@example.com', 'PostgreSQL Bootcamp', 'Intermediate', 2999.00, '2026-01-15', TRUE, 5, '{"instructor": "Dr. Sen", "duration_weeks": 8}', ARRAY['SQL', 'PostgreSQL', 'Database Design']),
-- ('Isha Choudhury', 'isha.c@example.com', 'Python Fundamentals', 'Beginner', 1999.00, '2026-03-10', TRUE, 4, '{"instructor": "Prof. Rao", "duration_weeks": 6}', ARRAY['Python', 'Logic Building', 'Git']),
-- ('Kabir Deshmukh', 'kabir.d@example.com', 'Advanced Machine Learning', 'Advanced', 5999.00, '2026-05-20', FALSE, NULL, '{"instructor": "Dr. Sen", "duration_weeks": 12}', ARRAY['Python', 'Scikit-Learn', 'Math']),
-- ('Sanya Kapoor', 'sanya.k@example.com', 'UI/UX Design Masterclass', 'Intermediate', 3499.00, '2026-02-01', TRUE, 5, '{"instructor": "Ananya S.", "duration_weeks": 10}', ARRAY['Figma', 'Wireframing', 'Prototyping']),
-- ('Aditya Joshi', 'aditya.j@example.com', 'Docker & Kubernetes', 'Advanced', 4500.00, '2026-06-14', FALSE, NULL, '{"instructor": "Rajesh Kumar", "duration_weeks": 8}', ARRAY['Docker', 'Kubernetes', 'DevOps']),
-- ('Meera Pillai', 'meera.p@example.com', 'Full-Stack React & Node', 'Intermediate', 4999.00, '2026-04-18', TRUE, 4, '{"instructor": "Amit Verma", "duration_weeks": 16}', ARRAY['React', 'Node.js', 'Express', 'MongoDB']),
-- ('Devansh Saxena', 'devansh.s@example.com', 'Python Fundamentals', 'Beginner', 1999.00, '2026-07-01', FALSE, NULL, '{"instructor": "Prof. Rao", "duration_weeks": 6}', ARRAY['Python']),
-- ('Riya Singhal', 'riya.s@example.com', 'PostgreSQL Bootcamp', 'Intermediate', 2999.00, '2026-03-22', TRUE, 4, '{"instructor": "Dr. Sen", "duration_weeks": 8}', ARRAY['SQL', 'PostgreSQL']),
-- ('Arjun Bannerjee', 'arjun.b@example.com', 'Data Structures & Algorithms', 'Intermediate', 3999.00, '2026-01-10', TRUE, 5, '{"instructor": "Vikram Seth", "duration_weeks": 12}', ARRAY['Java', 'DSA', 'Problem Solving']),
-- ('Anika Murthy', 'anika.m@example.com', 'Cloud Architecture AWS', 'Advanced', 5500.00, '2026-05-05', FALSE, NULL, '{"instructor": "Rajesh Kumar", "duration_weeks": 10}', ARRAY['AWS', 'Cloud Security', 'Terraform']);

SELECT * FROM course_enrollment;

SELECT course_meta->>'instructor' AS Instructor FROM course_enrollment;

SELECT * FROM course_enrollment WHERE 'React' = ANY(skills);

SELECT * FROM course_enrollment WHERE level = 'Beginner';

SELECT DISTINCT course_name FROM course_enrollment;

SELECT student_name, price FROM course_enrollment ORDER BY price DESC;
SELECT student_name, price FROM course_enrollment ORDER BY price ASC;

SELECT * FROM course_enrollment ORDER BY enrolled_on ASC LIMIT 5;

-- Names starting with 'A'
SELECT * FROM course_enrollment WHERE student_name LIKE 'A%';
-- Names ending with 'ena'
SELECT * FROM course_enrollment WHERE student_name LIKE '%ena';

-- Names containing 'an' anywhere
SELECT * FROM course_enrollment WHERE student_name LIKE '%an%';

-- Names with exactly 5 characters (4 any + 'a')
SELECT * FROM course_enrollment WHERE student_name LIKE '____a';

-- Names starting with 'A' or 'B', 3 chars long
SELECT * FROM course_enrollment WHERE student_name LIKE '[AB]__';

-- Case-insensitive (PostgreSQL uses ILIKE)
SELECT * FROM course_enrollment WHERE student_name ILIKE 'a%';

-- Exclude names starting with 'Z'
SELECT * FROM course_enrollment WHERE student_name NOT LIKE 'Z%';

SELECT * FROM course_enrollment WHERE price > 1000;
SELECT * FROM course_enrollment WHERE price < 2000;
SELECT * FROM course_enrollment WHERE price <= 2000;
SELECT * FROM course_enrollment WHERE price >= 2000;
SELECT * FROM course_enrollment WHERE rating <= 5;
SELECT * FROM course_enrollment WHERE rating != 5;

SELECT * FROM course_enrollment WHERE level = 'Intermediate' AND completion_status = true;
SELECT * FROM course_enrollment WHERE level = 'Beginner' OR level = 'Advance';

SELECT * FROM course_enrollment WHERE course_name IN ('Docker & Kubernetes');

SELECT * FROM course_enrollment WHERE price BETWEEN 3000 AND 4000;

SELECT COUNT(*) FROM course_enrollment;

SELECT SUM(price) FROM course_enrollment;

SELECT AVG(price) FROM course_enrollment;

SELECT MIN(price) FROM course_enrollment;

SELECT MAX(price) FROM course_enrollment;

SELECT course_name, SUM(price) AS revenue FROM course_enrollment GROUP BY course_name;

SELECT course_name, AVG(rating) AS avg_rating FROM course_enrollment GROUP BY course_name HAVING AVG(rating) IS NOT NULL;

SELECT completion_status, COUNT(*) FROM course_enrollment GROUP BY completion_status;

SELECT UPPER(student_name) FROM course_enrollment;

SELECT LOWER(student_name) FROM course_enrollment;
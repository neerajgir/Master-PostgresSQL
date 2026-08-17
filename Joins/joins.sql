-- Active: 1785411209906@@127.0.0.1@5432@joins
CREATE TABLE classes (
  class_id INT PRIMARY KEY,
  class_name VARCHAR(50) NOT NULL
);

CREATE TABLE students (
  student_id INT PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  class_id INT
);

INSERT INTO classes (class_id, class_name) VALUES
(101, 'JavaScript'),
(102, 'Python'),
(103, 'Java');

INSERT INTO students (student_id, name, class_id) VALUES
(1, 'Rahul', 101),
(2, 'Anjali', 102),
(3, 'Aman', 101),
(4, 'Neha', NULL);

SELECT * FROM students;
SELECT * FROM classes;

-- 1️⃣ INNER JOIN
SELECT s.name, c.class_name
FROM students s
INNER JOIN classes c
ON s.class_id = c.class_id;

-- 2️⃣ LEFT JOIN (LEFT OUTER JOIN)

SELECT s.name, c.class_name
FROM students s
LEFT JOIN classes c
ON s.class_id = c.class_id;



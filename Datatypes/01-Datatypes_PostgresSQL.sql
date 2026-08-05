CREATE TABLE course_enrollment (
    enrollment_id SERIAL PRIMARY KEY,
    student_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    course_name VARCHAR(50) NOT NULL,
    level VARCHAR(20),
    price NUMERIC(8,2) CHECK (price > 0),
    enrolled_on DATE DEFAULT CURRENT_DATE,
    completion_status BOOLEAN DEFAULT FALSE,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    course_meta JSONB,
    skills TEXT[]
);
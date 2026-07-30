CREATE TABLE students (
    id SERIAL,
    full_name VARCHAR(255) NOT NULL,
    agr INT,
    email VARCHAR(255) UNIQUE,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT NOW()
)


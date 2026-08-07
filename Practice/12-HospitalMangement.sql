CREATE TABLE doctors (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    specialization VARCHAR(100) NOT NULL,
    salary NUMERIC(10,2) NOT NULL CHECK (salary >= 0)
);

CREATE TABLE patients (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT NOT NULL CHECK (age >= 0),
    blood_group VARCHAR(5)
);

CREATE TABLE appointments (
    id SERIAL PRIMARY KEY,
    patient_id INT NOT NULL REFERENCES patients(id) ON DELETE CASCADE,
    doctor_id INT NOT NULL REFERENCES doctors(id) ON DELETE CASCADE,
    appointment_date TIMESTAMP NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'scheduled'
    CHECK (status IN ('scheduled', 'completed', 'cancelled'))
);

INSERT INTO patients (name, age, blood_group) VALUES
('Aarav Sharma', 34, 'B+'),
('Priya Patel', 27, 'O+'),
('Rohan Mehta', 45, 'A+'),
('Ananya Iyer', 19, 'AB+'),
('Vikram Singh', 52, 'O-'),
('Sneha Reddy', 31, 'B-'),
('Arjun Nair', 38, 'A-'),
('Kavya Krishnan', 24, 'O+'),
('Rahul Verma', 41, 'AB-'),
('Ishita Joshi', 29, 'B+'),
('Aditya Kumar', 60, 'A+'),
('Meera Pillai', 22, 'O+'),
('Karan Malhotra', 35, 'B+'),
('Divya Rao', 47, 'A-'),
('Siddharth Gupta', 55, 'AB+'),
('Neha Desai', 18, 'O-'),
('Manoj Chauhan', 63, 'B-'),
('Riya Bose', 26, 'A+'),
('Farhan Ahmed', 33, 'O+'),
('Pooja Yadav', 40, 'B+');


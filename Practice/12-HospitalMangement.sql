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

-- Doctors (10 rows, varied specializations)
INSERT INTO doctors (name, specialization, salary) VALUES
('Dr. Anil Kapoor', 'Cardiology', 185000.00),
('Dr. Sunita Rao', 'Dermatology', 142000.00),
('Dr. Vikas Agarwal', 'Orthopedics', 165000.00),
('Dr. Meenakshi Iyer', 'Pediatrics', 138000.00),
('Dr. Rajesh Khanna', 'Neurology', 210000.00),
('Dr. Shalini Menon', 'Gynecology', 155000.00),
('Dr. Amit Bhatia', 'General Medicine', 120000.00),
('Dr. Pooja Nair', 'ENT', 128000.00),
('Dr. Sanjay Chopra', 'Psychiatry', 148000.00),
('Dr. Deepika Rana', 'Ophthalmology', 132000.00);

-- Appointments (20 rows, linking patients 1-20 to doctors 1-10)
INSERT INTO appointments (patient_id, doctor_id, appointment_date, status) VALUES
(1, 1, '2025-01-05 09:00:00', 'completed'),
(2, 3, '2025-01-06 10:30:00', 'completed'),
(3, 2, '2025-01-06 11:00:00', 'cancelled'),
(4, 5, '2025-01-07 09:30:00', 'completed'),
(5, 4, '2025-01-08 14:00:00', 'scheduled'),
(6, 6, '2025-01-08 15:15:00', 'completed'),
(7, 1, '2025-01-09 09:45:00', 'scheduled'),
(8, 7, '2025-01-09 10:00:00', 'completed'),
(9, 8, '2025-01-10 11:30:00', 'cancelled'),
(10, 9, '2025-01-10 13:00:00', 'scheduled'),
(11, 10, '2025-01-11 09:00:00', 'completed'),
(12, 2, '2025-01-11 10:15:00', 'scheduled'),
(13, 3, '2025-01-12 11:45:00', 'completed'),
(14, 5, '2025-01-12 14:30:00', 'cancelled'),
(15, 4, '2025-01-13 09:15:00', 'scheduled'),
(16, 6, '2025-01-13 10:45:00', 'completed'),
(17, 1, '2025-01-14 12:00:00', 'scheduled'),
(18, 8, '2025-01-14 13:30:00', 'completed'),
(19, 9, '2025-01-15 09:00:00', 'scheduled'),
(20, 7, '2025-01-15 10:30:00', 'completed');

INSERT INTO appointments (patient_id, doctor_id, appointment_date)
VALUES (3, 2, '2025-01-20 10:00:00');

UPDATE appointments SET status = 'cancelled' WHERE patient_id = 19 AND doctor_id = 9 AND appointment_date = '2025-01-15 09:00:00';

SELECT * FROM appointments;

SELECT * FROM appointments WHERE status = 'scheduled' AND doctor_id = 1;


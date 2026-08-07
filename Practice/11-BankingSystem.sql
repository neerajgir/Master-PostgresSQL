CREATE TABLE clients (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE   
);

CREATE TABLE accounts (
    id SERIAL PRIMARY KEY,
    clients_id INT NOT NULL,
    account_number VARCHAR(20) NOT NULL UNIQUE,
    balance NUMERIC(15,2) NOT NULL DEFAULT 0.00 CHECK (balance >= 0.00),
    account_type VARCHAR(20) NOT NULL CHECK (account_type IN ('Savings', 'Checking', 'Current')),
    CONSTRAINT fk_clients FOREIGN KEY (clients_id) REFERENCES clients(id) ON DELETE RESTRICT
)

INSERT INTO clients (id, full_name, email) VALUES
(1, 'Aarav Sharma', 'aarav.sharma@email.com'),
(2, 'Priya Patel', 'priya.patel@email.com'),
(3, 'Rohan Das', 'rohan.das@email.com'),
(4, 'Ananya Iyer', 'ananya.iyer@email.com'),
(5, 'Amit Verma', 'amit.verma@email.com'),
(6, 'Sneha Reddy', 'sneha.reddy@email.com'),
(7, 'Vikram Malhotra', 'vikram.malhotra@email.com'),
(8, 'Kavita Rao', 'kavita.rao@email.com'),
(9, 'Rahul Joshi', 'rahul.joshi@email.com'),
(10, 'Neha Nair', 'neha.nair@email.com')
ON CONFLICT (id) DO NOTHING

SELECT setval('clients_id_seq', COALESCE((SELECT MAX(id) FROM clients), 1));

INSERT INTO accounts (clients_id, account_number, balance, account_type) VALUES
(1, 'ACC100019283', 45000.50, 'Savings'),
(2, 'ACC100028374', 125000.00, 'Checking'),
(3, 'ACC100037465', 8500.00, 'Savings'),
(4, 'ACC100046556', 310000.75, 'Current'),
(5, 'ACC100055647', 0.00, 'Checking'),
(6, 'ACC100064738', 92000.00, 'Savings'),
(7, 'ACC100073829', 1500.25, 'Savings'),
(8, 'ACC100082910', 64000.00, 'Current'),
(9, 'ACC100092001', 1250.00, 'Checking'),
(10, 'ACC100101112', 520000.00, 'Savings');
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
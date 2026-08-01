-- Mini Project
CREATE TABLE books (
    id SERIAL PRIMARY KEY,    
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    price NUMERIC(5, 2) CHECK (price > 0),
    stock INT CHECK (stock >= 0),
    metadata JSONB DEFAULT '{}'::JSONB
);

CREATE TABLE members (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    is_active BOOLEAN DEFAULT TRUE
);

CREATE TABLE borrow_history (
    id SERIAL PRIMARY KEY,
    books_id INT REFERENCES books(id),
    member_id INT REFERENCES members(id),
    borrow_date TIMESTAMP DEFAULT NOW(),
    returned BOOLEAN DEFAULT FALSE
);
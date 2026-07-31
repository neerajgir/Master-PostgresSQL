-- CREATE TABLE customers(
--     id SERIAL PRIMARY KEY,
--     name VARCHAR(255) NOT NULL,
--     profile JSONB DEFAULT '{}'::JSONB,
--     created_at TIMESTAMP DEFAULT NOw()
-- );


-- INSERT INTO customers (
--     name,
--     profile
-- )
-- VALUES (
--     'Neeraj',
--     '{
--         "city": "Karachi",
--         "phone": "03332203040",
--         "age": 24    
--     }'
-- );

-- SELECT * FROM customers;

SELECT profile-> 'city' AS city FROM customers;
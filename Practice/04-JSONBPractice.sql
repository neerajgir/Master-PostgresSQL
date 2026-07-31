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
--         "skills": ["HTML", "CSS", "JS", "REACT", "NODEJS"]  
--     }'
-- );

-- SELECT * FROM customers;

SELECT profile->'skills'->>0 AS Skills FROM customers;
SELECT profile->'skills'->>1 AS Skills FROM customers;
-- SELECT profile-> 'city' AS city FROM customers;
-- SELECT profile->> 'city' AS city FROM customers; return as text

-- SELECT profile->> 'phone' AS Phone FROM customers;
-- SELECT profile->> 'age' AS Age FROM customers;
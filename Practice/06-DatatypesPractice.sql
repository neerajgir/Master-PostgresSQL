-- CREATE TABLE orders (
--     id SERIAL PRIMARY KEY,
--     customer_name VARCHAR(255) NOT NULL,
--     total_amount NUMERIC(10, 2),
--     is_paid BOOLEAN DEFAULT true,
--     order_details JSONB DEFAULT '{}'::JSONB,
--     created_at TIMESTAMP DEFAULT NOW()
-- )

-- INSERT INTO orders (
--     customer_name,
--     total_amount,
--     is_paid,
--     order_details
-- )
-- VALUES (
--     'Neeraj',
--     5000,
--     true,
--     '{
--     "items":[
--         {
--             "product":"Laptop",
--             "qty":2
--         },
--         {
--             "product":"Mouse",
--             "qty":1
--         }
--     ]
-- }'
-- );

-- SELECT * FROM orders;
-- get product
SELECT order_details->'items'->0->>'product' AS first_product FROM orders;

-- get quantity
SELECT (order_details->'items'->0->>'qty')::int AS first_product_qty FROM orders;

-- get second product
SELECT order_details->'items'->1->>'product' AS second_product
FROM orders
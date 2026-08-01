CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    customer_name VARCHAR(255) NOT NULL,
    total_amount NUMERIC(10, 2),
    is_paid BOOLEAN DEFAULT true,
    order_details JSONB DEFAULT '{}'::JSONB,
    created_at TIMESTAMP DEFAULT NOW()
)
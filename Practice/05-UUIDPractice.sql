-- CREATE Table contractors (
--     id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
--     username VARCHAR(255) NOT NULL,
--     email VARCHAR(255) NOT NULL UNIQUE,
--     created_at TIMESTAMP DEFAULT NOW()
-- );

INSERT INTO contractors (
    username,
    email
)
VALUES (
    'Neeraj Goswami',
    'neerajcontractor@gmail.com'
);

SELECT * FROM contractors;
CREATE TABLE customers (
    customer_id  SERIAL PRIMARY KEY,
    first_name   VARCHAR(50)  NOT NULL,
    last_name    VARCHAR(50)  NOT NULL,
    email        VARCHAR(100) UNIQUE NOT NULL,
    city         VARCHAR(50),
    state        VARCHAR(50),
    signup_date  DATE NOT NULL
);


CREATE TABLE categories (
    category_id   SERIAL PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL
);


CREATE TABLE products (
    product_id   SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category_id  INT REFERENCES categories(category_id),
    price        NUMERIC(10,2) NOT NULL,
    stock_qty    INT DEFAULT 0
);

CREATE TABLE orders (
    order_id    SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    order_date  DATE NOT NULL,
    status      VARCHAR(20) CHECK (status IN ('Delivered','Pending','Cancelled','Returned'))
);

CREATE TABLE order_items (
    item_id    SERIAL PRIMARY KEY,
    order_id   INT REFERENCES orders(order_id),
    product_id INT REFERENCES products(product_id),
    quantity   INT NOT NULL,
    unit_price NUMERIC(10,2) NOT NULL
);


INSERT INTO categories (category_name) VALUES
('Electronics'),
('Clothing'),
('Home & Kitchen'),
('Books'),
('Sports & Fitness');


INSERT INTO customers (first_name, last_name, email, city, state, signup_date) VALUES
('Rahul',   'Sharma',   'rahul.sharma@email.com',   'Mumbai',    'Maharashtra',    '2022-01-15'),
('Priya',   'Singh',    'priya.singh@email.com',    'Delhi',     'Delhi',          '2022-02-20'),
('Amit',    'Verma',    'amit.verma@email.com',     'Bangalore', 'Karnataka',      '2022-03-10'),
('Neha',    'Gupta',    'neha.gupta@email.com',     'Chennai',   'Tamil Nadu',     '2022-04-05'),
('Vijay',   'Kumar',    'vijay.kumar@email.com',    'Hyderabad', 'Telangana',      '2022-05-18'),
('Anjali',  'Patel',    'anjali.patel@email.com',   'Ahmedabad', 'Gujarat',        '2022-06-22'),
('Rohit',   'Joshi',    'rohit.joshi@email.com',    'Pune',      'Maharashtra',    '2022-07-11'),
('Sneha',   'Rao',      'sneha.rao@email.com',      'Kolkata',   'West Bengal',    '2022-08-30'),
('Karan',   'Mehta',    'karan.mehta@email.com',    'Jaipur',    'Rajasthan',      '2022-09-14'),
('Pooja',   'Nair',     'pooja.nair@email.com',     'Kochi',     'Kerala',         '2022-10-07'),
('Suresh',  'Reddy',    'suresh.reddy@email.com',   'Hyderabad', 'Telangana',      '2022-11-25'),
('Divya',   'Iyer',     'divya.iyer@email.com',     'Chennai',   'Tamil Nadu',     '2022-12-03'),
('Manish',  'Tiwari',   'manish.tiwari@email.com',  'Lucknow',   'Uttar Pradesh',  '2023-01-19'),
('Kavya',   'Pillai',   'kavya.pillai@email.com',   'Kochi',     'Kerala',         '2023-02-08'),
('Arjun',   'Bose',     'arjun.bose@email.com',     'Kolkata',   'West Bengal',    '2023-03-27'),
('Ritu',    'Mishra',   'ritu.mishra@email.com',    'Bhopal',    'Madhya Pradesh', '2023-04-15'),
('Deepak',  'Chauhan',  'deepak.chauhan@email.com', 'Delhi',     'Delhi',          '2023-05-01'),
('Anita',   'Desai',    'anita.desai@email.com',    'Surat',     'Gujarat',        '2023-06-12'),
('Nikhil',  'Shah',     'nikhil.shah@email.com',    'Mumbai',    'Maharashtra',    '2023-07-21'),
('Meena',   'Kapoor',   'meena.kapoor@email.com',   'Amritsar',  'Punjab',         '2023-08-09'),
('Sanjay',  'Yadav',    'sanjay.yadav@email.com',   'Patna',     'Bihar',          '2023-09-16'),
('Lakshmi', 'Venkat',   'lakshmi.venkat@email.com', 'Bangalore', 'Karnataka',      '2023-10-04'),
('Tushar',  'Kulkarni', 'tushar.kulk@email.com',    'Pune',      'Maharashtra',    '2023-11-28'),
('Swati',   'Ghosh',    'swati.ghosh@email.com',    'Kolkata',   'West Bengal',    '2023-12-17'),
('Varun',   'Malhotra', 'varun.malh@email.com',     'Delhi',     'Delhi',          '2024-01-06'),
('Isha',    'Bajaj',    'isha.bajaj@email.com',      'Chandigarh','Punjab',        '2024-02-14'),
('Pranav',  'Deshpande','pranav.desh@email.com',    'Nagpur',    'Maharashtra',    '2024-03-22'),
('Shreya',  'Agarwal',  'shreya.agarwal@email.com', 'Agra',      'Uttar Pradesh',  '2024-04-10'),
('Mohit',   'Saxena',   'mohit.saxena@email.com',   'Indore',    'Madhya Pradesh', '2024-05-05'),
('Nisha',   'Pandey',   'nisha.pandey@email.com',   'Varanasi',  'Uttar Pradesh',  '2024-06-01');


INSERT INTO products (product_name, category_id, price, stock_qty) VALUES
('Samsung Galaxy S23',        1, 54999.00, 150),
('Apple MacBook Air M2',      1, 114999.00, 80),
('boAt Rockerz 450 Headset',  1,  1499.00, 500),
('Lenovo IdeaPad Laptop',     1, 45999.00, 100),
('Noise ColorFit Pro Watch',  1,  2999.00, 300),
('Men Running Shoes',         2,  2499.00, 400),
('Women Kurti Set',           2,   899.00, 600),
('Mens Casual T-Shirt',       2,   499.00, 800),
('Winter Jacket',             2,  3499.00, 200),
('Formal Trousers',           2,  1299.00, 350),
('Prestige Induction Cooktop',3,  3299.00, 120),
('Milton Steel Water Bottle', 3,   599.00, 700),
('Godrej Air Purifier',       3,  8999.00,  60),
('Solimo Bedsheet Set',       3,  1199.00, 250),
('Philips Air Fryer',         3,  6499.00,  90),
('Data Structures by Narasimha',4,  449.00,1000),
('Python Crash Course',       4,   599.00, 800),
('The Alchemist',             4,   199.00,1200),
('Yoga Mat 6mm',              5,   799.00, 500),
('Dumbbell Set 10kg',         5,  1899.00, 200);



INSERT INTO orders (customer_id, order_date, status) VALUES
(1,  '2022-02-10', 'Delivered'),
(2,  '2022-03-15', 'Delivered'),
(3,  '2022-04-20', 'Delivered'),
(4,  '2022-05-05', 'Cancelled'),
(5,  '2022-06-18', 'Delivered'),
(6,  '2022-07-22', 'Delivered'),
(7,  '2022-08-11', 'Returned'),
(8,  '2022-09-30', 'Delivered'),
(9,  '2022-10-14', 'Delivered'),
(10, '2022-11-07', 'Pending'),
(11, '2022-12-25', 'Delivered'),
(12, '2023-01-03', 'Delivered'),
(13, '2023-02-19', 'Delivered'),
(14, '2023-03-08', 'Cancelled'),
(15, '2023-04-27', 'Delivered'),
(1,  '2023-05-15', 'Delivered'),
(2,  '2023-06-01', 'Delivered'),
(3,  '2023-07-21', 'Returned'),
(16, '2023-08-09', 'Delivered'),
(17, '2023-09-16', 'Delivered'),
(18, '2023-10-04', 'Delivered'),
(19, '2023-11-28', 'Delivered'),
(20, '2023-12-17', 'Delivered'),
(5,  '2024-01-06', 'Delivered'),
(6,  '2024-01-14', 'Pending'),
(21, '2024-02-22', 'Delivered'),
(22, '2024-03-10', 'Delivered'),
(23, '2024-04-05', 'Delivered'),
(24, '2024-04-18', 'Cancelled'),
(25, '2024-05-01', 'Delivered'),
(7,  '2024-05-15', 'Delivered'),
(8,  '2024-05-28', 'Delivered'),
(26, '2024-06-03', 'Delivered'),
(27, '2024-06-15', 'Delivered'),
(28, '2024-07-01', 'Delivered'),
(29, '2024-07-20', 'Returned'),
(30, '2024-08-05', 'Delivered'),
(1,  '2024-08-18', 'Delivered'),
(2,  '2024-09-01', 'Delivered'),
(9,  '2024-09-22', 'Delivered'),
(10, '2024-10-10', 'Pending'),
(11, '2024-10-25', 'Delivered'),
(12, '2024-11-05', 'Delivered'),
(13, '2024-11-18', 'Delivered'),
(3,  '2024-11-28', 'Delivered'),
(4,  '2024-12-05', 'Cancelled'),
(14, '2024-12-10', 'Delivered'),
(15, '2024-12-15', 'Delivered'),
(16, '2024-12-20', 'Delivered'),
(17, '2024-12-28', 'Delivered');


INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(1,  1, 1, 54999.00),(1, 19, 1, 799.00),
(2,  6, 2,  2499.00),(2, 17, 1, 599.00),
(3,  2, 1,114999.00),
(4,  8, 3,   499.00),(4, 18, 2, 199.00),
(5,  5, 1,  2999.00),(5, 12, 2, 599.00),
(6, 11, 1,  3299.00),(6, 14, 1,1199.00),
(7,  9, 1,  3499.00),(7,  7, 2, 899.00),
(8,  3, 1,  1499.00),(8, 16, 1, 449.00),
(9,  4, 1, 45999.00),
(10,20, 1,  1899.00),(10,19,1,  799.00),
(11,13, 1,  8999.00),
(12, 1, 1, 54999.00),(12,12,2,  599.00),
(13,15, 1,  6499.00),(13,14,1, 1199.00),
(14, 8, 5,   499.00),
(15, 6, 1,  2499.00),(15,17,2,  599.00),
(16, 2, 1,114999.00),(16,19,1,  799.00),
(17, 7, 3,   899.00),(17,16,1, 449.00),
(18, 9, 1,  3499.00),
(19, 3, 2,  1499.00),(19,20,1, 1899.00),
(20, 5, 1,  2999.00),(20,12,1,  599.00),
(21,11, 1,  3299.00),(21,18,3,  199.00),
(22, 4, 1, 45999.00),(22,16,2,  449.00),
(23,13, 1,  8999.00),(23,19,1,  799.00),
(24, 8, 4,   499.00),
(25, 1, 1, 54999.00),(25,17,1,  599.00),
(26,15, 1,  6499.00),
(27, 6, 2,  2499.00),(27,20,1, 1899.00),
(28, 2, 1,114999.00),
(29, 9, 1,  3499.00),(29,14,2, 1199.00),
(30, 5, 2,  2999.00),(30,12,2,  599.00),
(31, 3, 1,  1499.00),(31,18,1,  199.00),
(32, 7, 2,   899.00),(32,16,1,  449.00),
(33,11, 1,  3299.00),(33,19,2,  799.00),
(34, 4, 1, 45999.00),
(35,13, 1,  8999.00),(35,20,1, 1899.00),
(36, 6, 1,  2499.00),
(37, 1, 1, 54999.00),(37,17,2,  599.00),
(38,15, 1,  6499.00),(38,12,1,  599.00),
(39, 2, 1,114999.00),(39,19,1,  799.00),
(40, 5, 1,  2999.00),(40,18,1,  199.00),
(41,20, 2,  1899.00),
(42, 9, 1,  3499.00),(42,14,1, 1199.00),
(43, 3, 2,  1499.00),(43,16,2,  449.00),
(44, 7, 3,   899.00),(44,12,2,  599.00),
(45, 6, 1,  2499.00),(45,17,1,  599.00),
(46, 8, 6,   499.00),
(47,11, 1,  3299.00),(47,18,2,  199.00),
(48,13, 1,  8999.00),(48,19,1,  799.00),
(49, 4, 1, 45999.00),(49,20,1, 1899.00),
(50, 1, 1, 54999.00),(50,15,1, 6499.00);



SELECT 'customers'   AS table_name, COUNT(*) AS total_rows FROM customers
UNION ALL
SELECT 'categories',                COUNT(*)               FROM categories
UNION ALL
SELECT 'products',                  COUNT(*)               FROM products
UNION ALL
SELECT 'orders',                    COUNT(*)               FROM orders
UNION ALL
SELECT 'order_items',               COUNT(*)               FROM order_items;
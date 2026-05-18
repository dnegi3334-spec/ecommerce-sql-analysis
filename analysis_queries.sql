-- ================================
-- E-Commerce Sales Analysis
-- ================================

-- =====================
-- BASIC QUERIES
-- =====================


-- Q1. How many customers are there in total?
SELECT COUNT (*) AS total_customers 
FROM customers;


-- Q2. How many total orders were placed?
SELECT COUNT (*) AS total_orders
FROM orders;


-- Q3. Show the count of orders by each status (Delivered, Pending, Cancelled, Returned)
SELECT status, COUNT (*) AS order_status
FROM orders
GROUP BY status;


-- Q4. What is the total revenue generated from delivered orders only?
SELECT ROUND(SUM(oi.quantity * oi.unit_price), 2) AS total_revenue
FROM order_items AS oi
JOIN orders o ON oi.order_id = o.order_id
WHERE o.status = 'Delivered';


-- Q5. How many products are there in each category?
SELECT c.category_name, COUNT(p.product_id) AS product_count
FROM categories AS c
JOIN products p ON c.category_id = p.category_id
GROUP BY c.category_name;


-- Q6. List all customers who signed up in 2023?
SELECT first_name, last_name, email, city, state
FROM customers
WHERE EXTRACT(YEAR FROM signup_date) = 2023;


-- Q7. What is the most expensive and cheapest product?
SELECT MAX(price) AS expensive_item,
	   MIN(price) AS cheapest_item
FROM products;




-- =====================
-- MEDIUM QUERIES
-- =====================


-- Q8. What is the monthly revenue trend year-wise?
SELECT EXTRACT(YEAR FROM o.order_date) AS year,
       EXTRACT(MONTH FROM o.order_date) AS month,
	   ROUND(SUM(oi.quantity * oi.unit_price), 2) AS monthly_revenue
FROM orders AS o
JOIN order_items AS oi ON o.order_id = oi.order_id
WHERE o.status = 'Delivered'
GROUP BY year, month
ORDER BY year, month;


--  Q9. What are the top 5 best selling products by quantity sold?
SELECT 
    p.product_name,
    SUM(oi.quantity) AS total_units_sold
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN orders o ON oi.order_id = o.order_id
WHERE o.status = 'Delivered'
GROUP BY p.product_name
ORDER BY total_units_sold DESC
LIMIT 5;


-- Q10. What is the total revenue by each category?
SELECT 
    c.category_name,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS category_revenue
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
JOIN products p ON oi.product_id = p.product_id
JOIN categories c ON p.category_id = c.category_id
WHERE o.status = 'Delivered'
GROUP BY c.category_name
ORDER BY category_revenue DESC;


-- Q11. What is the year-over-year total revenue?
SELECT 
    EXTRACT(YEAR FROM o.order_date) AS year,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS total_revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.status = 'Delivered'
GROUP BY year
ORDER BY year;


-- Q12. What is the Average Order Value (AOV)?
SELECT 
    ROUND(AVG(order_total), 2) AS avg_order_value
FROM (
    SELECT 
        o.order_id,
        SUM(oi.quantity * oi.unit_price) AS order_total
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.status = 'Delivered'
    GROUP BY o.order_id
) AS order_totals;


-- Q13. What is the cancellation and return rate by year?
SELECT 
    EXTRACT(YEAR FROM order_date) AS year,
    COUNT(*) AS total_orders,
    SUM(CASE WHEN status = 'Cancelled' THEN 1 ELSE 0 END) AS cancelled,
    SUM(CASE WHEN status = 'Returned'  THEN 1 ELSE 0 END) AS returned,
    ROUND(SUM(CASE WHEN status IN ('Cancelled','Returned') THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS loss_rate_pct
FROM orders
GROUP BY year
ORDER BY year;


-- Q14. Who are the top 10 customers by total spend?
SELECT 
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    c.city,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.status = 'Delivered'
GROUP BY c.customer_id, customer_name, c.city
ORDER BY total_spent DESC
LIMIT 10;


-- Q15. Which customers placed more than 1 order? (Repeat Customers)
SELECT 
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    c.email,
    COUNT(o.order_id) AS number_of_orders
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, customer_name, c.email
HAVING COUNT(o.order_id) > 1
ORDER BY number_of_orders DESC;


-- Q16. What is the state-wise revenue distribution?
SELECT 
    c.state,
    COUNT(DISTINCT c.customer_id) AS total_customers,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS state_revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.status = 'Delivered'
GROUP BY c.state
ORDER BY state_revenue DESC;


-- Q17. How many new customers joined each year?
SELECT 
    EXTRACT(YEAR FROM signup_date) AS signup_year,
    COUNT(*) AS new_customers
FROM customers
GROUP BY signup_year
ORDER BY signup_year;


-- Q18. Which customers never placed an order?
SELECT 
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    c.email,
    c.signup_date
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;


-- Q19. What is the average spend per customer by state?
SELECT 
    c.state,
    ROUND(AVG(customer_spend.total_spent), 2) AS avg_spend_per_customer
FROM customers c
JOIN (
    SELECT 
        o.customer_id,
        SUM(oi.quantity * oi.unit_price) AS total_spent
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.status = 'Delivered'
    GROUP BY o.customer_id
) AS customer_spend ON c.customer_id = customer_spend.customer_id
GROUP BY c.state
ORDER BY avg_spend_per_customer DESC;


-- =====================
-- ADVANCED QUERIES
-- =====================

-- Q20. Running total of revenue month-wise using Window Function
SELECT 
    year,
    month,
    monthly_revenue,
    ROUND(SUM(monthly_revenue) OVER (PARTITION BY year ORDER BY month), 2) AS running_total
FROM (
    SELECT 
        EXTRACT(YEAR FROM o.order_date)  AS year,
        EXTRACT(MONTH FROM o.order_date) AS month,
        ROUND(SUM(oi.quantity * oi.unit_price), 2) AS monthly_revenue
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.status = 'Delivered'
    GROUP BY year, month
) AS monthly
ORDER BY year, month;

 
-- Q21. Rank products by revenue within each category
SELECT 
    c.category_name,
    p.product_name,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS product_revenue,
    RANK() OVER (
        PARTITION BY c.category_name 
        ORDER BY SUM(oi.quantity * oi.unit_price) DESC
    ) AS rank_in_category
FROM order_items oi
JOIN orders o     ON oi.order_id   = o.order_id
JOIN products p   ON oi.product_id = p.product_id
JOIN categories c ON p.category_id = c.category_id
WHERE o.status = 'Delivered'
GROUP BY c.category_name, p.product_id, p.product_name
ORDER BY c.category_name, rank_in_category;


-- Q22. Customer segmentation using CTE (High / Mid / Low value)
WITH customer_spend AS (
    SELECT 
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        ROUND(SUM(oi.quantity * oi.unit_price), 2) AS total_spent
    FROM customers c
    JOIN orders o       ON c.customer_id = o.customer_id
    JOIN order_items oi ON o.order_id    = oi.order_id
    WHERE o.status = 'Delivered'
    GROUP BY c.customer_id, customer_name
)
SELECT 
    customer_name,
    total_spent,
    CASE 
        WHEN total_spent >= 100000 THEN 'High Value'
        WHEN total_spent >= 30000  THEN 'Mid Value'
        ELSE 'Low Value'
    END AS customer_segment
FROM customer_spend
ORDER BY total_spent DESC;


-- Q23. Month-over-month revenue growth rate using LAG()
WITH monthly_revenue AS (
    SELECT 
        EXTRACT(YEAR FROM o.order_date)  AS year,
        EXTRACT(MONTH FROM o.order_date) AS month,
        ROUND(SUM(oi.quantity * oi.unit_price), 2) AS revenue
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.status = 'Delivered'
    GROUP BY year, month
)
SELECT 
    year,
    month,
    revenue,
    LAG(revenue) OVER (ORDER BY year, month) AS prev_month_revenue,
    ROUND(
        (revenue - LAG(revenue) OVER (ORDER BY year, month)) * 100.0 
        / NULLIF(LAG(revenue) OVER (ORDER BY year, month), 0), 2
    ) AS growth_rate_pct
FROM monthly_revenue
ORDER BY year, month;


-- Q24. Which products were never sold? (Dead Stock)
SELECT 
    p.product_name,
    c.category_name,
    p.price,
    p.stock_qty AS unsold_stock
FROM products p
JOIN categories c ON p.category_id = c.category_id
WHERE p.product_id NOT IN (
    SELECT DISTINCT product_id FROM order_items
);


-- Q25. Top product in each category by revenue
WITH ranked_products AS (
    SELECT 
        c.category_name,
        p.product_name,
        ROUND(SUM(oi.quantity * oi.unit_price), 2) AS revenue,
        RANK() OVER (
            PARTITION BY c.category_id 
            ORDER BY SUM(oi.quantity * oi.unit_price) DESC
        ) AS rnk
    FROM order_items oi
    JOIN orders o     ON oi.order_id   = o.order_id
    JOIN products p   ON oi.product_id = p.product_id
    JOIN categories c ON p.category_id = c.category_id
    WHERE o.status = 'Delivered'
    GROUP BY c.category_id, c.category_name, p.product_id, p.product_name
)
SELECT category_name, product_name, revenue
FROM ranked_products
WHERE rnk = 1
ORDER BY revenue DESC;
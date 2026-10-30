use sql7challenge;
-- 1. total customers
SELECT COUNT(*)  as total_customers FROM customers ;
-- 2.customers by city
SELECT city, COUNT(*)
FROM customers
GROUP BY city;
-- 3.top 10 customers by order count
SELECT customer_id, COUNT(*)
FROM orders
WHERE status != 'Cancelled'
GROUP BY customer_id
ORDER BY COUNT(*) DESC
LIMIT 10;
desc orders;

-- 4.customer spending
SELECT o.customer_id, SUM(oi.quantity * oi.unit_price) AS total_spending
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.status != 'Cancelled'
GROUP BY o.customer_id;
desc order_items;
-- 5.average spending per customer
SELECT o.customer_id, AVG(oi.quantity * oi.unit_price) AS average_spending
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.status != 'Cancelled'
GROUP BY o.customer_id;

-- 6.customers more than 5 orders
SELECT customer_id, COUNT(*) AS total_orders
FROM orders
WHERE status != 'Cancelled'
GROUP BY customer_id
HAVING COUNT(*) > 5;

-- 7. customer segment analysis
SELECT segment, COUNT(*)
FROM customers
GROUP BY segment;
-- 8. avg order per customer
SELECT AVG(order_count) AS average_orders
FROM (
    SELECT c.customer_id, COUNT(o.order_id) AS order_count
    FROM customers c
    LEFT JOIN orders o
        ON c.customer_id = o.customer_id
        AND o.status != 'Cancelled'
    GROUP BY c.customer_id
) AS customer_orders;
-- 9. top 10 customers by spending
SELECT o.customer_id, SUM(oi.quantity * oi.unit_price) AS total_spending
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.status != 'Cancelled'
GROUP BY o.customer_id
ORDER BY total_spending DESC
LIMIT 10;

-- 10.customer signups by month
SELECT MONTH(signup_date), COUNT(*)
FROM customers
GROUP BY MONTH(signup_date)
ORDER BY MONTH(signup_date);
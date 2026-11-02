use sql7challenge;
-- 1.total sales values
show tables;
describe order_items;
SELECT ROUND(SUM(oi.quantity * oi.unit_price), 2) AS total_sales
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
WHERE o.status != 'Cancelled';
-- 2.sales by product category
SELECT
    p.category,
    SUM(oi.quantity * oi.unit_price) AS total_sales
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN orders o ON oi.order_id = o.order_id
WHERE o.status != 'Cancelled'
GROUP BY p.category
ORDER BY total_sales DESC;
-- 3. top 10 products by sales value
SELECT
    p.product_name,
    SUM(oi.quantity * oi.unit_price) AS total_sales
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN orders o ON oi.order_id = o.order_id
WHERE o.status != 'Cancelled'
GROUP BY p.product_id, p.product_name
ORDER BY total_sales DESC
LIMIT 10;
-- 4.total quantity sold by product
SELECT
    product_id,
    SUM(quantity) AS total_quantity
FROM order_items
GROUP BY product_id
ORDER BY total_quantity DESC;
-- 5.avg selling price by category
SELECT
    p.category,
    ROUND(AVG(oi.unit_price), 2) AS average_price
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.category;
-- 6.sales by sales channel
SELECT
    o.channel,
    SUM(oi.quantity * oi.unit_price) AS total_sales
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.status != 'Cancelled'
GROUP BY o.channel
ORDER BY total_sales DESC;
-- 7.estimated product profit
SELECT
p.product_name,
SUM(oi.quantity * (oi.unit_price - p.cost)) AS estimated_profit
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY estimated_profit DESC;
-- 8.top 5 categories by quantity sold
SELECT
    p.category,
    SUM(oi.quantity) AS total_quantity
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY total_quantity DESC
LIMIT 5;
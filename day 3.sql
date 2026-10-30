use sql7challenge;
-- 1.total sales value

select sum(oi.quantity*oi.unit_price) as total_sales
from orders o
join order_items oi
on o.order_id = oi.order_id
where status <> 'cancelled';

-- 2.revenue by product category
select p.category,sum(oi.quantity*oi.unit_price)as revenue
from orders o
join order_items oi
on o.order_id=oi.order_id
join products p
on oi.product_id=p.product_id
where o.status<>'cancelled'
group by p.category
order by revenue asc;

-- 3.top 10 products by revenue
SELECT
    p.product_name,
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id
WHERE o.status <> 'cancelled'
GROUP BY p.product_id, p.product_name
ORDER BY total_revenue DESC
LIMIT 10;

-- 4. monthly revenue trend
SELECT 
    MONTH(o.order_date) AS month,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM orders o
JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY MONTH(o.order_date)
ORDER BY month;

-- 5. revenue by sales channel
SELECT
o.channel,
SUM(oi.quantity * oi.unit_price) AS revenue
FROM orders o
JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY o.channel;
desc orders;

-- 6.total quantity sold by product category
SELECT
p.category,
SUM(oi.quantity) AS total_quantity_sold
FROM products p
JOIN order_items oi
ON p.product_id = oi.product_id
GROUP BY p.category
ORDER BY total_quantity_sold DESC;
desc payments;
-- 7.payment method analysis
SELECT
    payment_method,
    COUNT(*) AS total_payments
FROM payments
GROUP BY payment_method;

-- 8.payment status analysis
SELECT
    payment_status,
    COUNT(*) AS total_payments
FROM payments
GROUP BY payment_status;

-- 9.average amount payment
SELECT
    AVG(amount) AS average_payment
FROM payments;

-- 10.payment amount by payment method
SELECT
    payment_method,
    SUM(amount) AS total_payment_amount
FROM payments
GROUP BY payment_method
ORDER BY total_payment_amount DESC;
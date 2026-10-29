use sql7challenge;
-- 1.count total no.of orders
select count(*) as total_orders
from orders;

-- 2.count how many orders exist for each status
select status,count(*)as total_orders
from orders
group by status;

-- 3. 10 most recent orders
select * from orders
order by order_date desc
limit 10;

-- 4. 10 highest value orders
select order_id,sum(quantity*unit_price)as total_amount
from order_items
group by order_id
order by total_amount desc
limit 10;

describe order_items;

-- 5.count orders placed per day in chronological order

select order_date,count(*) as total_orders
from orders
group by order_date
order by order_date asc;

-- 6.monthly order trend
select month(order_date),count(*) as total_orders
from orders
group by month(order_date)
order by  month(order_date) asc;

-- 7. avg order value rounded
select round(avg(order_amount),2) as avg_value
from
(select order_id,sum(quantity*unit_price) as order_amount
from order_items
group by order_id) as orders_total;

-- 8. top 10 customers by order count
select customer_id,count(*)as total_orders
from orders
group by customer_id
order by total_orders desc 
limit 10;


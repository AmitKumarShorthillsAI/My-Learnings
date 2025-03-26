-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Set operations<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< --
USE sql_store;
SELECT order_id, order_date, 'Active' AS Status
FROM orders 
WHERE order_date >=  '2019-01-01'

UNION ALL

SELECT order_id, order_date, 'Archieved' AS Status
FROM orders 
WHERE order_date <  '2019-01-01';

-- Intersect operation (Emulated syntax since INTERSECT is not supported in MySql)
SELECT DISTINCT column_list
FROM table1
INNER JOIN table2 USING(join_condition);

-- Minus operation (Emulated syntax since MINUS is not supported in MySql)
SELECT column_list
FROM table1
LEFT JOIN table2 ON conditions
WHERE table2.column_name IS NULL;

-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Subqueries<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< --
USE sql_invoicing;
SELECT client_id, payment_total
FROM invoices
WHERE payment_total > (SELECT AVG(payment_total) FROM invoices);

USE sql_store;
SELECT customer_id, first_name, points
FROM customers
WHERE customer_id IN (SELECT customer_id FROM orders);		-- IN Clause

USE sql_store;
SELECT customer_id, first_name, last_name
FROM customers c
WHERE EXISTS (SELECT 1
				FROM orders o
                WHERE c.customer_id = o.customer_id);		-- EXISTS Clause
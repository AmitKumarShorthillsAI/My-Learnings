-- USE sql_store;

-- SELECT *
-- FROM order_items
-- WHERE order_id = 6 AND quantity * unit_price > 30;

-- SELECT *
-- FROM customers
-- WHERE state IN ('VA', 'FL', "GA");

-- SELECT * 
-- FROM customers
-- WHERE birth_date BETWEEN '1990-01-01' AND '2000-01-01';

-- SELECT *
-- FROM customers
-- WHERE last_name NOT LIKE 'b%';

-- SELECT *
-- FROM customers
-- WHERE last_name REGEXP '[a-h]e';

-- SELECT *
-- FROM orders
-- WHERE shipper_id IS NULL;

-- SELECT *, quantity * unit_price AS total_price
-- FROM order_items
-- WHERE order_id = 2 
-- ORDER BY total_price DESC;

-- SELECT *
-- FROM customers
-- ORDER BY points DESC
-- LIMIT 3;

-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> INNER JOINS <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< --

-- SELECT o.product_id, name, quantity, o.unit_price
-- FROM order_items AS o
-- JOIN products AS p
-- 	ON o.product_id = p.product_id;

-- Joining across databases --
-- SELECT *
-- FROM order_items o
-- JOIN sql_inventory.products p              -- Prefixing the table which is not the part of current database(sql_store)
-- 	ON o.product_id = p.product_id;

--  -------------------------------------------------Self join--------------------------------------- --
-- USE sql_hr;
-- SELECT e.employee_id, e.first_name, m.first_name AS manager
-- FROM employees AS e
-- JOIN employees AS m
-- 	ON e.reports_to = m.employee_id;

-- ---------------------------------------------Joining multiple tables-------------------------------------  --
-- USE sql_store;
--
-- SELECT o.order_id, o.order_date, c.first_name, c.last_name, os.name AS Order_status
-- FROM orders o
-- JOIN customers c                          -- Joins customers table with orders table
-- 	ON o.customer_id = c.customer_id
-- JOIN order_statuses os                    -- Joins order_statuses table with orders table
-- 	ON o.status = os.order_status_id;

-- -------------------------------------------Compound join conditions------------------------------ -- 
-- USE sql_store;

-- SELECT *
-- FROM order_items oi
-- JOIN order_item_notes oin
-- 	ON oi.order_id = oin.order_Id
--     AND oi.product_id = oin.product_id -- Compound join is done bcoz both the table didn't have any column which uniquely identifies them

-- ------------------------------------------Implicit join syntax--------------------------------------- --
-- USE sql_store;

-- SELECT *
-- FROM orders o
-- JOIN customers c
-- 	ON o.customer_id = c.customer_id;
--     
-- -- Both are same, below one is implicit syntax, and is not recommended to use.
--     
-- SELECT *
-- FROM orders o, customers c
-- WHERE o.customer_id = c.customer_id;

-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> OUTER JOINS <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< --

-- USE sql_store;

-- SELECT p.product_id, p.name, oi.quantity
-- FROM products p
-- LEFT JOIN order_items oi
-- 	ON p.product_id = oi.product_id;

-- ----------------------------------Outer Join b/w multiple tables---------------------------------------------- --
-- USE sql_store;
-- SELECT c.customer_id, c.first_name, o.order_id, s.name AS Shipper
-- FROM customers c
-- LEFT JOIN orders o
-- 	ON c.customer_id = o.customer_id
-- LEFT JOIN shippers s
-- 	ON s.shipper_id = o.shipper_id
-- ORDER BY c.first_name;

-- -------------------------------------Self outer join---------------------------------- --
-- USE sql_hr;
-- SELECT e.employee_id, e.first_name, m.first_name AS Manager
-- FROM employees AS e
-- LEFT JOIN employees AS m    -- CEO will not have any manager so inner join will exclude him
-- 	ON e.reports_to = m.employee_id;

-- ------------------------------------Using Clause-------------------------------------- --
-- USE sql_store;
-- SELECT o.order_id, c.first_name, s.name AS Shipper
-- FROM orders o
-- JOIN customers c
-- 	-- ON o.customer_id = c.customer_id
--     USING (customer_id)    -- This can be used in place of above, it can be used when both have same col name
-- LEFT JOIN shippers s
-- 	USING (shipper_id);

-- USE sql_store;
-- SELECT *
-- FROM order_items oi
-- JOIN order_item_notes oin
-- -- 	ON oi.order_id = oin.order_Id
-- --     AND oi.product_id = oin.product_id
-- 	USING (order_id, product_id);           -- Here combination of both cols uniquely identify them

-- ---------------------------------Natural Joins----------------------------------------------- --
-- USE sql_store;
-- SELECT o.order_id, c.first_name, o.customer_id
-- FROM orders o
-- NATURAL JOIN customers c;   -- It automatically determines based on common cols

-- ---------------------------------Cross Joins------------------------------------------------- --
-- USE sql_store;
-- SELECT s.name AS Shipper_name, p.name AS Product_name
-- FROM shippers s
-- CROSS JOIN products p
-- ORDER BY s.name;

-- -------------------------------Unions--------------------------------------------------- --
USE sql_store;
SELECT order_id, order_date, 'Active' AS Status
FROM orders 
WHERE order_date >=  '2019-01-01'

UNION

SELECT order_id, order_date, 'Archieved' AS Status
FROM orders 
WHERE order_date <  '2019-01-01';
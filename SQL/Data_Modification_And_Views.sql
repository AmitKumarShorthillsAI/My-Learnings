-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Data Modification<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< --
-- >>>>> Inserting data
CREATE DATABASE ORG;
SHOW DATABASES;
USE ORG;

CREATE TABLE worker(
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT, -- Primary key ensures that id is unique in all rows
    firstName char(25),
    lastName char(25),
    salary INT(15),
    joiningDate DATETIME,
    department CHAR(25)
);
    
INSERT INTO worker(id, firstName, lastName, salary, joiningDate, department) VALUES
	(001, 'Monika', 'Arora', 100000, '14-02-20 09.00.00', 'HR'),
    (002, 'Niharika', 'verma', 80000, '14-07-21 09.00.00', 'Admin'),
    (003, 'Vishal', 'singhal', 200000, '15-02-20 09.00.00', 'Account'),
    (004, 'Daiyu', 'singh', 50000, '14-01-20 09.00.00', 'HR'),
    (005, 'Vipul', 'Arora', 300000, '14-06-20 09.00.00', 'Manager'),
    (006, 'Vivek', 'Bhati', 75000, '14-02-20 09.00.00', 'Admin'),
    (007, 'Sanjana', 'Malviya', 90000, '14-03-22 09.00.00', 'HR'),
    (008, 'Geetika', 'Chauhan', 110000, '14-02-11 09.00.00', 'Account');
    
-- >>>>>> Inserting Hierarchical Rows 
USE sql_store;
INSERT INTO orders (customer_id, order_date, status)
VALUES (1, '2025-03-27', 1);

INSERT INTO order_items				-- It is a child table of 'orders' table
VALUES 
	(LAST_INSERT_ID(), 1, 1, 2.89), -- LAST_INSERT_ID() only returns automatically generated AUTO_INCREMENT values
    (LAST_INSERT_ID(), 2, 1, 3.95);
    
-- >>>>> Creating a copy of a table

USE sql_store;
-- CREATE TABLE orders_archieved AS
INSERT INTO orders_archieved		-- Truncate the above created table, it will get empty, after that we can insert into that
SELECT *
FROM orders
WHERE order_date < '2019-01-01';

USE sql_invoicing;
CREATE TABLE invoices_archieved AS 
SELECT 
	i.invoice_id,
    c.name AS Client_name,
    i.number,
    i.invoice_total,
    i.payment_total,
    i.invoice_date,
    i.due_date,
    i.payment_date
FROM invoices i
JOIN clients c
	USING(client_id)
WHERE payment_date IS NULL;

-- >>>>>>> Updating single and multiple rows
USE sql_invoicing;
UPDATE invoices
SET 
	payment_total = invoice_total * 0.5,
    payment_date = '2025-03-27'
-- WHERE invoice_id = 4;			-- Updates single row with the given invoice_id
WHERE client_id IN (3, 4);		-- Updates multiple invoices by these clients

-- Update data
USE ORG;
UPDATE worker SET salary=500000, department='Cheif Manager', lastName='sah' WHERE id=8;
-- Update multiple rows
SET SQL_SAFE_UPDATES = 0; -- first we have to turn off(put value = 0) the safe mode enabled by default
UPDATE worker SET salary = salary + 5000;

-- Updating using subqueries
USE sql_invoicing;
UPDATE invoices
SET 
	payment_total = invoice_total * 0.5,
    payment_date = '2025-03-27'
WHERE client_id IN
			(SELECT client_id
            FROM clients
            WHERE state IN ('CA', 'NY'));
            
-- >>>>>> Deleting and Replace data
USE ORG;
-- Delete
DELETE FROM worker WHERE id = 005;

-- Delete Cascade
DELETE FROM worker WHERE id = 3;  -- when there is no any attribute of 'ON DELETE CASCADE' then it will not get deleted since worker might have child references of another tables

-- DELETE SET NULL
DELETE FROM worker WHERE id = 7; -- 7 or 007 || And here parent will get deleted and child will get updated to null value

-- REPLACE
-- If data is already present then it will be replaced otherwise it will be added, but if we are using UPDATE then it will only update when data is present
REPLACE INTO worker(id, firstName, lastName) VALUES (1, 'Manika', 'Arora');
REPLACE INTO worker(id, firstName, lastName) VALUES (9, 'Manika', 'Batra');
UPDATE worker SET salary=100000, department='HR', lastName='sah' WHERE id=1;

-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Views<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< --
USE sql_store;
CREATE VIEW custom_view AS SELECT first_name, customer_id FROM customers;	-- Creating a view
SELECT * FROM custom_view;	-- Viewing the VIEW
ALTER VIEW custom_view AS SELECT customer_id, first_name, last_name FROM customers;	-- Altering the views
DROP VIEW IF EXISTS custom_view;
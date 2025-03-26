-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>String Functions<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< --
-- USE sql_store;
-- SELECT 
-- 	UPPER(first_name) AS upper,
--     LOWER(last_name) AS Lower,
--     SUBSTRING(first_name, 2, 4) AS Substring,
--     CONCAT(first_name, last_name) AS Concatenate,
--     REPLACE(first_name, 'Elka', 'Alka') AS Replaced,
--     TRIM(first_name) AS Trimmed_Spaces
-- FROM customers

-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Aggregate Functions<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< --
-- USE sql_invoicing;
-- SELECT 
-- 	COUNT(amount),
--     SUM(amount),
--     MAX(amount),
--     MIN(amount),
--     ROUND(AVG(amount), 2)
-- FROM payments p;

-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Group By & Having Clause<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< --
-- USE sql_invoicing;
-- SELECT payment_method, SUM(amount) AS total
-- FROM payments p
-- GROUP BY payment_method
-- HAVING total > 10
-- ORDER BY total

-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Timestamp & Extract Functions<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< --
SELECT @@global.time_zone;		-- This returns the global time zone setting.
SELECT @@session.time_zone;		-- This shows the time zone for your current session.
SELECT @@system_time_zone;		-- This returns the time zone set in the OS (Ubuntu, Windows, etc.).
SELECT NOW(), @@session.time_zone; -- If empty, you need to load the time zone tables (mysql_tzinfo_to_sql).
SELECT NOW();
SELECT CURRENT_TIMESTAMP;    -- Same as NOW()
SELECT CURRENT_TIME;
SELECT CURRENT_DATE;
SELECT CURDATE() AS Date, CURTIME() AS Time, NOW() AS DateTime;


USE sql_invoicing;
SELECT 
	EXTRACT(MONTH FROM invoice_date) AS month,
    EXTRACT(YEAR FROM invoice_date) AS Year,
    EXTRACT(QUARTER FROM invoice_date) AS Quarter,
    EXTRACT(WEEK FROM invoice_date) AS Week,
    EXTRACT(DAY FROM NOW()) AS Day,
    EXTRACT(HOUR FROM NOW()) AS Hour,
    EXTRACT(MINUTE FROM NOW()) AS Minute,
    WEEKDAY(NOW()) + 1 AS Day_Of_Week,
    DAYOFYEAR(NOW()) AS Day_Of_Year
FROM invoices;

-- >>>>>>>>>>>>>>>>>>>>>>>>Additionals<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< --
SELECT DATE_ADD(NOW(), INTERVAL 7 DAY) AS Date_After_adding_interval;
SELECT DATE_ADD(NOW(), INTERVAL 7 DAY) AS Date_After_Subtracting_interval;
SELECT DATEDIFF('2025-03-21', '2025-03-01') AS Date_diff;
SELECT TIMEDIFF('10:10:00', '15:40:10');
SELECT TIMESTAMPDIFF(YEAR, '2000-01-01', NOW()) AS TimeStamp_diff;
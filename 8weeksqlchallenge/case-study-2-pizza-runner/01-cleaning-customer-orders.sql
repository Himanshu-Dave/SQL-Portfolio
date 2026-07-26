--CLEANING THE Customer ORDERS TABLE FOR EASIER DATA ANALYSIS AND EDA
SELECT *
FROM pizza_runner.customer_orders;

SELECT COLUMN_NAME , DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'customer_orders'
 AND TABLE_SCHEMA = 'Pizza_runner'

UPDATE pizza_runner.customer_orders
SET exclusions = NULL
where exclusions = '' ; 

UPDATE pizza_runner.customer_orders
SET extras = NULL
WHERE extras = '' ;


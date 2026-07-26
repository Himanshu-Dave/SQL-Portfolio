--CLEANING THE RUNNER ORDERS TABLE FOR EASIER DATA ANALYSIS AND EDA

SELECT *
FROM pizza_runner.runner_orders
WHERE cancellation is null;

Update pizza_runner.runner_orders
set distance = REPLACE(distance , 'km' ,'');

Update pizza_runner.runner_orders
set duration = REPLACE(REPLACE(REPLACE(duration , 'mins' ,'') , 'minutes' , '') ,'minute' , '');

UPDATE pizza_runner.runner_orders
SET cancellation = 'No'
WHERE cancellation IS NULL;

SELECT *
FROM pizza_runner.runner_orders;

UPDATE pizza_runner.runner_orders
SET cancellation = 'No'
WHERE cancellation = '' ;


SELECT *
FROM pizza_runner.runner_orders;

EXEC sp_rename 'pizza_runner.runner_orders.distance' , 'distance_km' ,'COLUMN' ;

EXEC sp_rename 'pizza_runner.runner_orders.duration', 'duration_min' ,'COLUMN';

SELECT *
FROM pizza_runner.runner_orders;

SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'runner_orders'
  AND TABLE_SCHEMA = 'pizza_runner';

ALTER TABLE pizza_runner.runner_orders
ALTER COLUMN distance_km float;

ALTER TABLE pizza_runner.runner_orders
ALTER COLUMN duration_min int;

ALTER TABLE pizza_runner.runner_orders
ALTER COLUMN pickup_time DATETIME;

SELECT *
FROM pizza_runner.runner_orders;

SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'runner_orders'
  AND TABLE_SCHEMA = 'pizza_runner';



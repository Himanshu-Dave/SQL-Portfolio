  ----------------------------------EDA------------------------------------------
 
 --A. PIZZA METRICS                                               
 --Q1. How many pizzas were ordered?

SELECT 
COUNT(*) as TotalPizzaOrdered 
FROM pizza_runner.runner_orders r
LEFT JOIN pizza_runner.customer_orders c
	ON r.ordeR_id = c.order_id
WHERE cancellation = 'No' ;

--Q2. How many unique customer orders were made?

SELECT 
COUNT(DISTINCT c.order_id) as UniqueCustomerOrders 
FROM pizza_runner.runner_orders r
RIGHT JOIN pizza_runner.customer_orders c
	ON r.ordeR_id = c.order_id;


--Q3. How many successful orders were delivered by each runner?

SELECT
runner_id,
COUNT(*) AS successfulorders
FROM pizza_runner.runner_orders
WHERE cancellation = 'No'
GROUP BY runner_id;

--Q4. How many of each type of pizza was delivered?

SELECT 
c.Pizza_id,
COUNT(*) as PizzaDelivered
FROM pizza_runner.runner_orders r
RIGHT JOIN pizza_runner.customer_orders c
	ON r.ordeR_id = c.order_id
WHERE r.cancellation = 'No'
GROUP BY c.pizza_id ;

--Q5. How many Vegetarian and Meatlovers were ordered by each customer?

SELECT 
customer_id,
Pizza_id,
COUNT(*) as PizzaOrdered
FROM pizza_runner.customer_orders
GROUP BY customer_id, pizza_id
ORDER BY customer_id ;

--Q6. What was the maximum number of pizzas delivered in a single order?

WITH PizzaCounts as (
SELECT 
c.order_id,
COUNT(*) as PizzaDeliveredPerOrder
FROM pizza_runner.runner_orders r
RIGHT JOIN pizza_runner.customer_orders c
	ON r.ordeR_id = c.order_id
WHERE r.cancellation = 'No'
GROUP BY c.order_id 
)

SELECT 
order_id,
PizzaDeliveredPerOrder AS MaxiPizzaDelivered
FROM PizzaCounts
WHERE PizzaDeliveredPerOrder = (SELECT MAX(PizzaDeliveredPerOrder) FROM PizzaCounts);

--Q7. For each customer, how many delivered pizzas had at least 1 change and how many had no changes?

WITH IsChange AS(
SELECT
	c.customer_id,
	c.order_id,
	c.exclusions,
	c.extras,
	CASE
		WHEN c.exclusions IS NOT NULL OR c.extras IS NOT NULL THEN 'Yes'
		WHEN c.exclusions IS NULL AND c.extras IS NULL THEN 'No'
	END AS Changed
FROM pizza_runner.customer_orders c
LEFT JOIN pizza_runner.runner_orders r
	ON c.order_id = r.order_id
WHERE r.cancellation = 'No'
)

SELECT
	customer_id,
	Changed,
	COUNT(*) as HowManyPizzas
FROM IsChange
GROUP BY customer_id , Changed ;

--Q8. How many pizzas were delivered that had both exclusions and extras?

WITH IsChange as(
SELECT
	c.customer_id,
	c.order_id,
	c.exclusions,
	c.extras,
	CASE
		WHEN c.exclusions IS NOT NULL AND c.extras IS NOT NULL THEN 'Yes'
		WHEN c.exclusions IS NULL AND c.extras IS NULL THEN 'No'
		ELSE 'AnyOneChanged'
	END AS Changed
FROM pizza_runner.customer_orders c
LEFT JOIN pizza_runner.runner_orders r
	ON c.order_id = r.order_id
WHERE r.cancellation = 'No'
)

SELECT
	COUNT(*) as Pizza_With_Both_Extras_And_Exclusions
FROM IsChange
WHERE Changed = 'Yes' ; 

--Q9. What was the total volume of pizzas ordered for each hour of the day?

SELECT 
	DATEPART (hour, order_time) as Hour ,
	COUNT(*) AS PizzaEachHour
FROM pizza_runner.customer_orders
GROUP BY DATEPART (hour, order_time) ;

--Q10. What was the volume of orders for each day of the week?

SELECT 
	DATENAME (WEEKDAY, order_time) as DAY ,
	COUNT(*) AS PizzaEachHour
FROM pizza_runner.customer_orders
GROUP BY DATENAME (WEEKDAY, order_time) ;





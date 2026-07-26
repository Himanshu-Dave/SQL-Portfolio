--D. PRICING AND RATINGS
--Q1. If a Meat Lovers pizza costs $12 and Vegetarian costs $10 and there were no charges for 
--changes - how much money has Pizza Runner made so far if there are no delivery fees?

SELECT	
	ro.runner_id,
	CAST(SUM(CASE
		WHEN co.pizza_id = 1 THEN 12
		ELSE 10
	END) AS VARCHAR) + '$' AS TotalCharges
FROM pizza_runner.runner_orders ro
JOIN pizza_runner.customer_orders co
	ON ro.order_id = co.order_id
WHERE ro.cancellation = 'No';

--Q2. What if there was an additional $1 charge for any pizza extras?
--Add cheese is $1 extra

WITH PizzaPrices AS(
SELECT	
	ro.runner_id,
	SUM(CASE
		WHEN co.pizza_id = 1 THEN 12
		ELSE 10
	END) AS PizzaCharges
FROM pizza_runner.runner_orders ro
JOIN pizza_runner.customer_orders co
	ON ro.order_id = co.order_id
WHERE ro.cancellation = 'No'
GROUP BY ro.runner_id
),
ExtraPrices AS(
SELECT	
	ro.runner_id,
	SUM(CASE
		WHEN value IS NOT NULL THEN 1
		ELSE 0
	END) AS ExtraCharges
FROM pizza_runner.runner_orders ro
JOIN pizza_runner.customer_orders co
	ON ro.order_id = co.order_id
OUTER APPLY string_split (co.extras , ',') 
WHERE ro.cancellation = 'No'
GROUP BY ro.runner_id
)

SELECT 
	ep.runner_id,
	pp.PizzaCharges + ep.ExtraCharges AS TotalCharges
FROM PizzaPrices pp
JOIN ExtraPrices ep
	ON ep.runner_id = pp.runner_id;

--Q3. The Pizza Runner team now wants to add an additional ratings system that allows
-- customers to rate their runner, how would you design an additional table for 
-- this new dataset - generate a schema for this new table and insert your own 
-- data for ratings for each successful customer order between 1 to 5.



--Using orer id to rate rather than runner id or something, cause in real-world cases,
--customer would rate orders , ofcourse in reality , it does depend on runner for example,
--his behiaviour, his ability to find accurate location etc.. but assuming they were same, i decided on this table.
--To get rating per runner, we can just join this table with runner_orders 
--also we can join it with customer_orders to get the rating based on which pizza
--was ordered etc.
CREATE TABLE pizza_runner.runner_rating(
order_id INT,
Rating FLOAT
);

--Using this table to give ratings.

SELECT 
	r.Order_id,
	DATEDIFF(MINUTE , c.order_time , r.pickup_time) + r.duration_min as Total_Time_Taken,
	COUNT(c.pizza_id) as NoOfPizzas
FROM pizza_runner.runner_orders r
JOIN pizza_runner.customer_orders c
	ON r.ordeR_id = c.order_id
WHERE cancellation = 'No'
GROUP BY r.order_id ,c.order_time , r.pickup_time,r.duration_min ;

INSERT INTO pizza_runner.runner_rating (ordeR_id ,  Rating)
Values 
	(1,2.5),
	(2,3),
	(3,4),
	(4,3),
	(5,4.5),
	(6,1),
	(7,4),
	(8,4),
	(9, NULL),
	(10,5)

--In order id 6, resturant cancelled the order and in order id 9, customer cancelled the order so  
--delivery never happened hence no rating

SELECT *
FROM pizza_runner.runner_rating;

--Q4. Using your newly generated table - can you join all of the information together to form
--a table which has the following information for successful deliveries?
--customer_id
--order_id
--runner_id
--rating
--order_time
--pickup_time
--Time between order and pickup
--Delivery duration
--Average speed
--Total number of pizzas

SELECT 
	c.customer_id,
	r.Order_id,
	r.runner_id,
	rr.Rating,
	c.order_time,
	r.pickup_time,
	DATEDIFF(MINUTE , c.order_time , r.pickup_time) AS Time_Taken,
	r.duration_min,
	AVG(distance_km / ((duration_min * 1.0) / 60)) as Avg_Speed_Kph,
	COUNT(c.pizza_id) as NoOfPizzas
FROM pizza_runner.runner_orders r
JOIN pizza_runner.customer_orders c
	ON r.ordeR_id = c.order_id
JOIN pizza_runner.runner_rating rr
	ON rr.order_id = r.order_id
WHERE cancellation = 'No'
GROUP BY r.order_id ,c.order_time , r.pickup_time,r.duration_min,c.customer_id,r.runner_id , rr.Rating;

--Q5. If a Meat Lovers pizza was $12 and Vegetarian $10 fixed prices with no
--cost for extras and each runner is paid $0.30 per kilometre traveled - how
--much money does Pizza Runner have left over after these deliveries?

WITH Revenue AS (
    SELECT 
        SUM(CASE WHEN c.pizza_id = 1 THEN 12 ELSE 10 END) AS TotalRevenue
    FROM pizza_runner.customer_orders c
    JOIN pizza_runner.runner_orders r 
        ON c.order_id = r.order_id
    WHERE r.cancellation = 'No'
),
Expenses AS (
    SELECT 
        SUM(distance_km * 0.30) AS TotalRunnerPay
    FROM pizza_runner.runner_orders
    WHERE cancellation = 'No'
)
SELECT 
    r.TotalRevenue,
    e.TotalRunnerPay,
    (r.TotalRevenue - e.TotalRunnerPay) AS Net_Profit
FROM Revenue r, Expenses e;

--Bonus-- If Danny wants to expand his range of pizzas - how would this impact the
--existing data design? Write an INSERT statement to demonstrate what would happen 
--if a new Supreme pizza with all the toppings was added to the Pizza Runner menu?

INSERT INTO pizza_runner.pizza_names (pizza_id, pizza_name)
VALUES (3, 'Supreme');

INSERT INTO pizza_runner.pizza_recipes (pizza_id, toppings)
VALUES (3, '1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12');

-- Adding a new pizza reveals the problem that the pizza_recipes table is highly error prone 
-- and inefficient to use. Every time I need to extract toppings from this table, I have to 
-- use STRING_SPLIT, which makes the query complex and inefficient. 
-- Ultimately, this non-normalized design makes scaling the database very difficult.




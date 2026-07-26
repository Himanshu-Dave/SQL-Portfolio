--B. RUNNER AND CUSTOMER EXPERIENCE
--Duration_min and distance_km are columns after data cleaning
--Q1. How many runners signed up for each 1 week period? (i.e. week starts 2021-01-01)

SELECT 
	DATEPART(WEEK , registration_date) AS WEEK,
	COUNT(*) AS  RunnersPerWeek
FROM pizza_runner.runners
GROUP BY DATEPART(WEEK , registration_date)

--Q2. What was the average time in minutes it took for each runner
--to arrive at the Pizza Runner HQ to pickup the order?

SELECT 
	AVG(DATEDIFF(MINUTE , order_time , pickup_time)) AS AvgDiffInMinutes
FROM pizza_runner.runner_orders r
JOIN pizza_runner.customer_orders c
	ON r.ordeR_id = c.order_id
WHERE cancellation = 'No' ;

--Q3. Is there any relationship between the number of pizzas and how long the order takes to prepare?

SELECT 
	r.Order_id,
	DATEDIFF(MINUTE , c.order_time , r.pickup_time) as DiffInMinutes,
	COUNT(c.pizza_id) as NoOfPizzas
FROM pizza_runner.runner_orders r
JOIN pizza_runner.customer_orders c
	ON r.ordeR_id = c.order_id
WHERE cancellation = 'No'
GROUP BY r.order_id ,c.order_time , r.pickup_time ;

--Yes, there is a relation, whenever there is only 1 pizza, time take is aroung 10 mins (with one outlier), 
--when there are 2 pizzas , time take is around 16-21 min , and whenever there are 3 pizza,
--time is aorund 30 min, means as no. of pizza inc, time take increases

--Q4. What was the average distance travelled for each customer? 

SELECT 
	c.customer_id,
	AVG(r.distance_km) as Avg_Dist_Travelled_In_Km
FROM pizza_runner.runner_orders r
JOIN pizza_runner.customer_orders c
	ON r.order_id = c.order_id
WHERE cancellation = 'No'
GROUP BY c.customer_id ;

--Q5. What was the difference between the longest and shortest delivery times for all orders?

SELECT 
		MAX(duration_min) - MIN(duration_min) AS Diff_Btw_Longest_Shortest_Delivery
	FROM pizza_runner.runner_orders 
	WHERE cancellation = 'No' ;

--Q6. What was the average speed for each runner for each delivery and 
--do you notice any trend for these values?

SELECT 
	runner_id,
	AVG(distance_km / (CAST(duration_min AS float) / 60)) as Avg_Speed_Kph
FROM pizza_runner.runner_orders r
WHERE cancellation = 'No'
GROUP BY runner_id;
-- runner 1 and 3 have pretty normal speeds but runner 2 drives way faster.

--Q7. What is the successful delivery percentage for each runner?

WITH cancel AS(
SELECT
	*,
	CASE 
		WHEN cancellation = 'No' then 1
	END as IsCancelled
FROM pizza_runner.runner_orders
)

SELECT 
	runner_id,
	(COUNT(IsCancelled)*1.0 / COUNT(*)*1.0) * 100 as Successful_Delivery
FROM cancel
GROUP BY runner_id;






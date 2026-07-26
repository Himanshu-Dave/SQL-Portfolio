--C. INGREDIENT OPTIMISATION
--Q1. What are the standard ingredients for each pizza?

WITH toppings_pizza as(
SELECT 
	pizza_id,
	TRIM(value) as toppings_sorted
FROM pizza_runner.pizza_recipes
CROSS APPLY string_split(toppings , ',')
)

SELECT 
	pn.pizza_id,
	pn.pizza_name,
	p.toppings_sorted,
	pt.topping_name
FROM toppings_pizza p 
JOIN pizza_runner.pizza_names pn
	ON pn.pizza_id = p.pizza_id
JOIN pizza_runner.pizza_toppings pt
	on pt.topping_id = p.toppings_sorted;

--Q2. What was the most commonly added extra?

SELECT 
	topping_name,
	topping_id,
	TimesIncluded
FROM (
	SELECT 
		pt.topping_name,
		value AS topping_id,
		count(*) AS TimesIncluded,
		RANK() OVER (ORDER BY COUNT(*) DESC) AS Ranking_Acc_To_Frequency
	FROM pizza_runner.customer_orders c
	CROSS APPLY string_split(extras , ',') 
	JOIN pizza_runner.pizza_toppings pt
		ON pt.topping_id = value
	GROUP BY value,pt.topping_name
)t
WHERE Ranking_Acc_To_Frequency = 1;

--Q3. What was the most common exclusion?

SELECT 
	topping_name,
	topping_id,
	TimesExcluded
FROM (
	SELECT 
		pt.topping_name,
		value as topping_id,
		count(*) AS TimesExcluded,
		RANK() OVER (ORDER BY COUNT(*) DESC) AS Ranking_Acc_To_Frequency
	FROM pizza_runner.customer_orders c
	CROSS APPLY string_split(exclusions , ',') 
	JOIN pizza_runner.pizza_toppings pt
		ON pt.topping_id = value
	GROUP BY value,pt.topping_name
)t
WHERE Ranking_Acc_To_Frequency = 1;

--Q4. Generate an order item for each record in the customers_orders table in the format of one of the following:
--Meat Lovers
--Meat Lovers - Exclude Beef
--Meat Lovers - Extra Bacon
--Meat Lovers - Exclude Cheese, Bacon - Extra Mushroom, Peppers
   
WITH Orders AS(
SELECT 
	order_id,
	customer_id,
	pizza_id,
	order_time,
	ROW_NUMBER() OVER(ORDER BY customer_id) AS UniqueId,
	exclusions,
	extras
FROM pizza_runner.customer_orders
),
Excluded AS(
SELECT 
	o.UniqueId,
	STRING_AGG (pt.topping_name , ', ') as Excluded_Toppings
FROM Orders o
OUTER APPLY string_split(o.exclusions , ',') as ex
LEFT JOIN pizza_runner.pizza_toppings pt
	ON pt.topping_id = TRIM(ex.value)
GROUP BY o.UniqueId
),
Extra AS(
SELECT 
	o.UniqueId,
	STRING_AGG (pt.topping_name , ', ') as Extra_Toppings
FROM Orders o
OUTER APPLY string_split(o.extras , ',') as ex
LEFT JOIN pizza_runner.pizza_toppings pt
	ON pt.topping_id = TRIM(ex.value)
GROUP BY o.UniqueId
)

SELECT 
	CASE 
		WHEN el.Excluded_Toppings IS NULL AND ex.Extra_Toppings IS NULL THEN pn.pizza_name
		WHEN el.Excluded_Toppings IS NOT NULL AND ex.Extra_Toppings IS NULL 
			THEN pn.pizza_name + ' - Exclude ' +  el.Excluded_Toppings
		WHEN el.Excluded_Toppings IS NULL AND ex.Extra_Toppings IS NOT NULL 
			THEN pn.pizza_name + ' - Extra ' + ex.Extra_Toppings
		WHEN el.Excluded_Toppings IS NOT NULL AND ex.Extra_Toppings IS NOT NULL 
			THEN pn.pizza_name + ' - Exclude ' + el.Excluded_Toppings + ' - Extra ' + ex.Extra_Toppings
	END AS Pizza_Order,
	o.UniqueId,
	o.customer_id,
	o.order_id,
	pn.pizza_name,
	el.Excluded_Toppings,
	ex.Extra_Toppings
FROM Orders o
LEFT JOIN Excluded el
	on el.UniqueId = o.UniqueId
LEFT JOIN Extra ex
	on ex.UniqueId = o.UniqueId
JOIN pizza_runner.pizza_names pn
	ON pn.pizza_id = o.pizza_id;


--Q5. Generate an alphabetically ordered comma separated ingredient list for each pizza
--order from the customer_orders table and add a 2x in front of any relevant ingredients
--For example: "Meat Lovers: 2xBacon, Beef, ... , Salami"

WITH Orders AS(
SELECT 
	order_id,
	customer_id,
	pizza_id,
	order_time,
	ROW_NUMBER() OVER(ORDER BY customer_id) AS UniqueId,
	exclusions,
	extras
FROM pizza_runner.customer_orders
),
Extra AS(
SELECT 
	o.UniqueId,
	pt.topping_name as Extra_Toppings
FROM Orders o
OUTER APPLY string_split(o.extras , ',') as ex
LEFT JOIN pizza_runner.pizza_toppings pt
	ON pt.topping_id = TRIM(ex.value)
),
Excluded AS(
SELECT 
	o.UniqueId,
	pt.topping_name as Excluded_Toppings
FROM Orders o
OUTER APPLY string_split(o.exclusions , ',') as ex
LEFT JOIN pizza_runner.pizza_toppings pt
	ON pt.topping_id = TRIM(ex.value)
),
ingredient AS(
SELECT
	o.UniqueId,
	pr.pizza_id,
	pt.topping_id,
	pt.topping_name
FROM pizza_runner.pizza_recipes pr
CROSS APPLY string_split(toppings , ',')
JOIN pizza_runner.pizza_toppings pt
	ON pt.topping_id = TRIM(value)
JOIN Orders o
	ON o.pizza_id = pr.pizza_id
),
Final_Topping_list AS(
SELECT 
	UniqueID,
	topping_name
FROM ingredient

UNION ALL

SELECT 
	UniqueId,
	Extra_Toppings
FROM Extra
WHERE Extra_Toppings IS NOT NULL
), 
FilteredTopping AS(
SELECT 
	UniqueId,
	topping_name
FROM Final_Topping_list ftl
WHERE NOT EXISTS(
		SELECT 1
		FROM Excluded el
		WHERE el.UniqueId = ftl.UniqueId
		AND	  el.Excluded_Toppings = ftl.topping_name
	)
)
SELECT 
	UniqueId,
	STRING_AGG(ToppingF , ', ')  WITHIN GROUP (ORDER BY ToppingF ASC) AS Final_Ingredient
FROM (
	SELECT
		UniqueId,
		Topping_Name,
		CASE 
			WHEN COUNT(topping_name) = 1 THEN topping_name
			WHEN COUNT(topping_name) > 1 THEN '2x' + topping_name
		END AS ToppingF
	FROM FilteredTopping
	GROUP BY UniqueId , Topping_Name
)t
GROUP BY UniqueId ;


--Q6. What is the total quantity of each ingredient used in all delivered pizzas sorted by most frequent first?

--Using prev question

WITH Orders AS(
SELECT 
	co.order_id,
	customer_id,
	pizza_id,
	order_time,
	ROW_NUMBER() OVER(ORDER BY customer_id) AS UniqueId,
	exclusions,
	extras
FROM pizza_runner.customer_orders co
	LEFT JOIN pizza_runner.runner_orders ro
		ON co.order_id = ro.order_id 
WHERE ro.cancellation = 'No'
),
Extra AS(
SELECT 
	o.UniqueId,
	pt.topping_name as Extra_Toppings
FROM Orders o
OUTER APPLY string_split(o.extras , ',') as ex
LEFT JOIN pizza_runner.pizza_toppings pt
	ON pt.topping_id = TRIM(ex.value)
),
Excluded AS(
SELECT 
	o.UniqueId,
	pt.topping_name as Excluded_Toppings
FROM Orders o
OUTER APPLY string_split(o.exclusions , ',') as ex
LEFT JOIN pizza_runner.pizza_toppings pt
	ON pt.topping_id = TRIM(ex.value)
),
ingredient AS(
SELECT
	o.UniqueId,
	pr.pizza_id,
	pt.topping_id,
	pt.topping_name
FROM pizza_runner.pizza_recipes pr
CROSS APPLY string_split(toppings , ',')
JOIN pizza_runner.pizza_toppings pt
	ON pt.topping_id = TRIM(value)
JOIN Orders o
	ON o.pizza_id = pr.pizza_id
),
Final_Topping_list AS(
SELECT 
	UniqueID,
	topping_name
FROM ingredient

UNION ALL

SELECT 
	UniqueId,
	Extra_Toppings
FROM Extra
WHERE Extra_Toppings IS NOT NULL
), 
FilteredTopping AS(
SELECT 
	UniqueId,
	topping_name
FROM Final_Topping_list ftl
WHERE NOT EXISTS(
		SELECT 1
		FROM Excluded el
		WHERE el.UniqueId = ftl.UniqueId
		AND	  el.Excluded_Toppings = ftl.topping_name
	)
)
SELECT
	Topping_Name,
	COUNT(*) as ToppingFreq
FROM FilteredTopping
GROUP BY Topping_Name
ORDER BY COUNT(*) DESC;

--Alternate

WITH DeliveredOrders AS (
    SELECT c.pizza_id, c.exclusions, c.extras
    FROM pizza_runner.customer_orders c
    JOIN pizza_runner.runner_orders r ON c.order_id = r.order_id
    WHERE r.cancellation = 'No'
),
IngredientList AS (
    SELECT TRIM(value) AS topping_id, 1 AS Quantity
    FROM DeliveredOrders d
    JOIN pizza_runner.pizza_recipes pr ON d.pizza_id = pr.pizza_id
    CROSS APPLY STRING_SPLIT(pr.toppings, ',')
    
    UNION ALL
    
    SELECT TRIM(value), 1
    FROM DeliveredOrders
    CROSS APPLY STRING_SPLIT(extras, ',')
    
    UNION ALL
    
    SELECT TRIM(value), -1
    FROM DeliveredOrders
    CROSS APPLY STRING_SPLIT(exclusions, ',')
)

SELECT 
    pt.topping_name,
    SUM(il.Quantity) AS Total_Quantity
FROM IngredientList il
JOIN pizza_runner.pizza_toppings pt 
    ON il.topping_id = pt.topping_id
GROUP BY pt.topping_name
ORDER BY Total_Quantity DESC;




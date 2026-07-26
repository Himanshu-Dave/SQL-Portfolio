--All questions are done in T-SQL/MSSQL

--Q1. What is the total amount each customer spent at the restaurant?

SELECT 
s.customer_id,
SUM(m.price)  spend_per_customer

FROM dannys_diner.sales s
LEFT JOIN dannys_diner.menu AS m
	ON s.product_id = m.product_id

GROUP BY s.customer_id;

--Q2. How many days has each customer visited the restaurant?

SELECT  
customer_id,
COUNT(DISTINCT order_date) AS Days_Visited

FROM dannys_diner.sales
GROUP BY customer_id;

--Q3. What was the first item from the menu purchased by each customer?

SELECT  
customer_id,
product_id,
product_name
FROM (
	SELECT  
	s.customer_id,
	s.product_id,
	m.product_name,
	ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY s.order_date) AS rn

	from dannys_diner.sales s
	LEFT JOIN dannys_diner.menu as m
		ON s.product_id = m.product_id
)t
WHERE rn = 1;

--Q4. What is the most purchased item on the menu and how many times was it purchased by all customers?

SELECT TOP 1
s.product_id,
m.product_name,
COUNT(*) AS Times_Purchased

FROM dannys_diner.sales s
LEFT JOIN dannys_diner.menu AS m
	ON s.product_id = m.product_id

GROUP BY s.product_id , m.product_name
ORDER BY count(*) DESC;

--Q5. Which item was the most popular for each customer?

WITH product_counts AS (
    SELECT 
        s.customer_id,
        s.product_id,
        m.product_name,
        COUNT(*) AS times_purchased

    FROM dannys_diner.sales  s
    JOIN dannys_diner.menu  m
        ON s.product_id = m.product_id

    GROUP BY s.customer_id, s.product_id, m.product_name
),
ranked AS (
    SELECT 
	*,
    RANK() OVER (PARTITION BY customer_id ORDER BY times_purchased DESC) AS rnk
    FROM product_counts
)
SELECT customer_id,
product_id,
product_name AS most_popular_product_per_customer
FROM ranked
WHERE rnk = 1;

--Q6. Which item was purchased first by the customer after they became a member?

SELECT 
customer_id,
product_name 
FROM (
	SELECT 
	mm.customer_id,
	m.product_name,
	RANK() OVER (PARTITION BY mm.customer_id ORDER BY order_date) AS rnk

	FROM dannys_diner.sales s
	LEFT JOIN dannys_diner.menu AS m
		ON s.product_id = m.product_id
	LEFT JOIN dannys_diner.members mm
		ON mm.customer_id = s.customer_id
	WHERE s.order_date >= mm.join_date
)t
WHERE rnk = 1;

--Q7. Which item was purchased just before the customer became a member?

SELECT
customer_id,
product_name 
FROM (
	SELECT 
	mm.customer_id,
	m.product_name,
	RANK() OVER (PARTITION BY mm.customer_id ORDER BY order_date DESC) AS rnk

	FROM dannys_diner.sales s
	LEFT JOIN dannys_diner.menu as m
		on s.product_id = m.product_id
	LEFT JOIN dannys_diner.members mm
		ON mm.customer_id = s.customer_id
	WHERE s.order_date < mm.join_date
)t
WHERE rnk = 1;
-- if only want to see one item , then change rank to row_number

--Q8. What is the total items and amount spent for each member before they became a member?

SELECT
mm.customer_id,
SUM(m.price) AS Total_Spent,
COUNT(*) AS Total_Items

FROM dannys_diner.sales s
LEFT JOIN dannys_diner.menu AS m
	ON s.product_id = m.product_id
LEFT JOIN dannys_diner.members mm
	ON mm.customer_id = s.customer_id

WHERE s.order_date < mm.join_date
GROUP BY mm.customer_id;

--Q9. If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?

SELECT 
s.Customer_id,
SUM(
CASE
	WHEN m.product_name = 'sushi' THEN price * 20
	ELSE price * 10
END ) AS points
FROM dannys_diner.sales s
LEFT JOIN dannys_diner.menu AS m
	ON s.product_id = m.product_id
GROUP BY s.customer_id;

--Q10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, 
--not just sushi - how many points do customer A and B have at the end of January?


SELECT 
s.customer_id,
SUM(
CASE
	WHEN s.product_id = 1 THEN price * 20
	WHEN DATEDIFF (DAY , mm.join_date , s.order_date) <=7 AND DATEDIFF (DAY , mm.join_date , s.order_date) >= 0  THEN price*20
	ELSE price * 10
END) AS Points

FROM dannys_diner.sales s
LEFT JOIN dannys_diner.menu AS m
	ON s.product_id = m.product_id
LEFT JOIN dannys_diner.members AS mm
	ON mm.customer_id = s.customer_id

WHERE MONTH (order_date) = 1 AND s.Customer_id in ('A' , 'B')
GROUP BY s.customer_id;


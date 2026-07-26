/*
Description- Assume you're given a table containing data on Amazon customers
and their spending on products in different category, write a query to identify
the top two highest-grossing products within each category in the year 2022.
The output should include the category, product, and total spend.

Link - https://datalemur.com/questions/sql-highest-grossing
*/
--Postgre SQL 14

SELECT
category,
product,
maxxed_spent AS total_spend
FROM  (SELECT 
        *,
        ROW_NUMBER() OVER(PARTITION BY category ORDER BY maxxed_spent DESC) AS rn
     FROM (
            SELECT 
            SUM(spend) as maxxed_spent,
            category,
            product
            from product_spend
            WHERE DATE_PART('year', transaction_date) = 2022
            group by product,category
    )a
    order by maxxed_spent DESC
)t 
group by category, product, maxxed_spent , t.rn
having rn = 1 OR rn = 2
order by category  ,maxxed_spent DESC






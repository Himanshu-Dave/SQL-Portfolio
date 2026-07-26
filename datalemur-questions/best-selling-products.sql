/*
Description-Write an SQL query to find the best-selling product in each product category.
If there are two or more products with the same sales quantity, go by whichever 
product which has the higher review rating.

Return the category name and product name in alphabetical order of the category.

Link - https://datalemur.com/questions/best-selling-products
*/
--Postgre SQL 14

SELECT category_name,
product_name
from (select *,
    dense_rank() over(partition by category_name order by sales_quantity DESC,rating DESC) as tops
    from product_sales ps 
    left join products p
    on ps.product_id = p.product_id
)t
where t.tops = 1
order by category_name , product_name



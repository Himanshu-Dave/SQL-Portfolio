/*
Description- A Microsoft Azure Supercloud customer is defined as a customer 
who has purchased at least one product from every product category listed 
in the products table.

Write a query that identifies the customer IDs of these Supercloud customers.

Link - https://datalemur.com/questions/supercloud-customer
*/
--Postgre SQL 14

select c.customer_id
from customer_contracts c
left join products p
on p.product_id = c.product_id
group by c.customer_id
having count(distinct p.product_category) = (select count(distinct product_category) from products)


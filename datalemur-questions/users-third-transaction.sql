/*
Description- Assume you are given the table below on Uber transactions
made by users. Write a query to obtain the third transaction of every user.
Output the user id, spend and transaction date.

Link - https://datalemur.com/questions/sql-third-transaction
*/
--Postgre SQL 14

SELECT
user_id,
spend,
transaction_date
FROM (
  select *,
  row_number() over(partition by user_id order by transaction_date) as rn
  from transactions
)t 
where rn = 3

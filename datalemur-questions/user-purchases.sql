/*
Description- Assume you're given a table on Walmart user transactions. 
Based on their most recent transaction date, write a query that retrieve
the users along with the number of products they bought.

Output the user's most recent transaction date, user ID, and the number of products,
sorted in chronological order by the transaction date.

Link - https://datalemur.com/questions/histogram-users-purchases
*/
--Postgre SQL 14

select max(transaction_date) as transaction_date,
user_id,
sum(dr) as purchase_count
from
    (SELECT *,
    dense_rank() over (partition by user_id order by transaction_date DESC) as dr
    FROM user_transactions
)t 
where dr = 1
group by user_id
order by max(transaction_date)



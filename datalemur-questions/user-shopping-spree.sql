/*
Description- In an effort to identify high-value customers, 
Amazon asked for your help to obtain data about users who go on shopping sprees.
A shopping spree occurs when a user makes purchases on 3 or more consecutive days.

List the user IDs who have gone on at least 1 shopping spree in ascending order.

Link - https://datalemur.com/questions/amazon-shopping-spree
*/
--Postgre SQL 14

select distinct user_id
from
      (SELECT *,
      transaction_date as curr_day,
      coalesce(lag(transaction_date) over(partition by user_id order by transaction_date),transaction_date) as lagged,
      coalesce(lag(transaction_date , 2) over(partition by user_id order by transaction_date),transaction_date) as lagged_2 
      FROM (
          select DISTINCT user_id,date(transaction_date) as transaction_date
          from transactions
      )a
    )t
where curr_day - lagged = 1 and lagged - lagged_2 = 1
order by user_id 




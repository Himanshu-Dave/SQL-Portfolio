/*
Description- Assume you're given a table containing information on Facebook user actions.
Write a query to obtain number of monthly active users (MAUs) in July 2022, 
including the month in numerical format "1, 2, 3".

Link - https://datalemur.com/questions/user-retention
*/
--Postgre SQL 14

with monthly_active as(
select 
extract(month from event_date) as curr_month,
lag(extract(month from event_date)) over(partition by user_id order by event_date) as prev_month,
user_id
from user_actions
where extract(year from event_date) = 2022
)

select 
curr_month as month,
count(distinct user_id) as monthly_active_users
from monthly_active 
where curr_month - prev_month = 1 and curr_month = 7
group by curr_month


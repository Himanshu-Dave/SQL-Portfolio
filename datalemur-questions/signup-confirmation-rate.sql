/*
Description- New TikTok users sign up with their emails. 
They confirmed their signup by replying to the text confirmation to activate
their accounts. Users may receive multiple text messages for account
confirmation until they have confirmed their new account.

A senior analyst is interested to know the activation rate of specified
users in the emails table. Write a query to find the activation rate.
Round the percentage to 2 decimal places.

Link - https://datalemur.com/questions/signup-confirmation-rate
*/
--Postgre SQL 14

WITH no_of_users AS (
    SELECT email_id,
           COUNT(user_id) OVER () AS userss
    FROM emails
)
select
    round((count(distinct t.email_id)*1.0 / max(n.userss)*1.0), 2) as confirm_rate
from no_of_users n
left join emails e on n.email_id = e.email_id
left join texts t on n.email_id = t.email_id
where t.signup_action = 'confirmed';


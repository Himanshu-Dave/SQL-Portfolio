/*
Description- Assume you're given tables with information on Snapchat users,
including their ages and time spent sending and opening snaps.

Write a query to obtain a breakdown of the time spent sending vs. opening snaps
as a percentage of total time spent on these activities grouped by age group.
Round the percentage to 2 decimal places in the output.

Link - https://datalemur.com/questions/time-spent-snaps
*/
--Postgre SQL 14

select
    ab.age_bucket,
    round(
        sum(case when a.activity_type = 'send' then a.time_spent else 0 end) * 100.0
        / sum(a.time_spent), 2
    ) as send_perc,
    round(
        sum(case when a.activity_type = 'open' then a.time_spent else 0 end) * 100.0
        / sum(a.time_spent), 2
    ) as open_perc
from activities a
join age_breakdown ab on a.user_id = ab.user_id
where lower(a.activity_type) != 'chat'
group by ab.age_bucket

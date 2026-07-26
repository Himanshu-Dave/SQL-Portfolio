/*
Description- Assume you're given a table with measurement values 
obtained from a Google sensor over multiple days with measurements
taken multiple times within each day.

Write a query to calculate the sum of odd-numbered and even-numbered
measurements separately for a particular day and display the results
in two different columns. Refer to the Example Output below for the desired format.

Link - https://datalemur.com/questions/odd-even-measurements
*/
--Postgre SQL 14

with odded_sum as (
select
*,
sum(measurement_value) over(partition by date_trunc('day', measurement_time)) as odd_sum
from( select *,
  row_number() over(partition by date_trunc('day', measurement_time) order by measurement_time) as rn
  from measurements
  )t
  where rn%2 = 1
),
evened_sum as (
select
*,
sum(measurement_value) over(partition by date_trunc('day', measurement_time)) as even_sum
from( select *,
  row_number() over(partition by date_trunc('day', measurement_time) order by measurement_time) as rn
  from measurements
  )t
where rn%2=0
)

select date_trunc('day', m.measurement_time),
max(coalesce(o.odd_sum,0)) as odd_sum,
max(coalesce(e.even_sum,0)) as even_sum
from measurements m
left join odded_sum o on m.measurement_id = o.measurement_id
left join evened_sum e on m.measurement_id = e.measurement_id
group by date_trunc('day', m.measurement_time)
order by date_trunc('day', m.measurement_time)





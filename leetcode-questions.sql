-- All questions below are in T-SQL/MSSQL

/*
Description- Write a solution to report all the duplicate emails. Note that it's guaranteed that the email field is not NULL.

Link - https://leetcode.com/problems/duplicate-emails/description/
*/

select distinct email
from (
    select *,
    sum(id) over(partition by email order by id) as summed
    from Person
)t
where summed != id

/*
Description- Write a solution to delete all duplicate emails, keeping only one unique email with the smallest id.

Link - https://leetcode.com/problems/delete-duplicate-emails/description/
*/

with cte as(
    select
    *,
    sum(id) over(partition by email order by id) as summed
    from Person
)
 delete from cte 
 where id != summed

/*
Description- Write a solution to find all dates' id with higher temperatures compared to its previous dates (yesterday).

Return the result table in any order.

Link - https://leetcode.com/problems/rising-temperature/description/
*/

select 
id
from (
    select
    *,
    lag(temperature,1,99999) over(order by recordDate) as PrevDayTemp,
    datediff(day, lag (recordDate) over (order by recordDate) ,recordDate) as DiffInDate
    from weather
)t
where temperature > PrevDayTemp and DiffInDate = 1

/*
Description- Write a solution to find the first login date for each player.

Return the result table in any order.

Link - https://leetcode.com/problems/game-play-analysis-i/description/
*/

select player_id,
event_date as first_login
from (
    select *,
    row_number() over(partition by player_id order by event_date) as rn
    from Activity
)t
where rn = 1

/*
Description- Write a solution to find the customer_number for the customer who has placed the largest number of orders.

The test cases are generated so that exactly one customer will have placed more orders than any other customer.

Link - https://leetcode.com/problems/customer-placing-the-largest-number-of-orders/description/
*/

select top 1 customer_number
from (
    select *,
    row_number() over(partition by customer_number order by order_number) as rn
    from Orders
)t
order by rn DESC

/*
Description- Write a solution to find all the classes that have at least five students.

Return the result table in any order.

Link - https://leetcode.com/problems/classes-with-at-least-5-students/description/
*/

select distinct class
from(
    select *,
    dense_rank() over(partition by class order by student) as dr
    from Courses
)t
where dr >= 5

/*
Description- Report for every three line segments whether they can form a triangle.

Return the result table in any order.

Link - https://leetcode.com/problems/triangle-judgement/description/
*/

select *,
case
when x + y > z and x + z > y and y + z > x  then 'Yes'
else 'No'
end as triangle
from Triangle

/*
Description- RA single number is a number that appeared only once in the MyNumbers table.

Find the largest single number. If there is no single number, report null.

Link - https://leetcode.com/problems/biggest-single-number/description/
*/

select max(rn2) as num 
from (
select *,
case
when sum(rn) over(partition by num) = 1 then num
else null
end as rn2
from (
select *,
row_number() over(partition by num order by num) as rn
from MyNumbers
)t
)a

/*
Description- Write a solution to find all the pairs (actor_id, director_id) where the actor 
has cooperated with the director at least three times.

Return the result table in any order.

Link - https://leetcode.com/problems/actors-and-directors-who-cooperated-at-least-three-times/description/
*/

select distinct actor_id, director_id
from(
select *,
sum(rn) over(partition by actor_id , director_id ) as summed
from(
select *,
row_number () oveR(partition by actor_id , director_id order by timestamp) as rn
from ActorDirector
)t
)a
where summed >= 6

/*
Description- Write an SQL query that reports the average experience years of
all the employees for each project, rounded to 2 digits.

Return the result table in any order.

Link - https://leetcode.com/problems/project-employees-i/description/
*/

SELECT 
    p.project_id,
    ROUND(AVG(cast(e.experience_years as float)), 2) AS average_years
FROM Project p
LEFT JOIN Employee e
    ON p.employee_id = e.employee_id
GROUP BY p.project_id
order by p.project_id


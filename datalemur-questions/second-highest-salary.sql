/*
Description- Imagine you're an HR analyst at a tech company tasked 
with analyzing employee salaries. Your manager is keen on understanding
the pay distribution and asks you to determine the second highest
salary among all employees.

It's possible that multiple employees may share the same 
second highest salary. In case of duplicate, display the 
salary only once.

Link - https://datalemur.com/questions/sql-second-highest-salary
*/
--Postgre SQL 14

SELECT 
salary as second_highest_salary
FROM (
  select *,
  dense_rank() over(order by salary DESC) dr
  from employee
)t
where dr = 2

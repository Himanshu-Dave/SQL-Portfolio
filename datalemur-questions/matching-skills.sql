/*
Matching Skills

Description- 
Given a table of candidates and their skills, you're tasked with finding
the candidates best suited for an open Data Science job. You want to find
candidates who are proficient in Python, Tableau, and PostgreSQL.

Write a query to list the candidates who possess all of the required
skills for the job. Sort the output by candidate ID in ascending order.

Link - https://datalemur.com/questions/matching-skills
*/
-- PostgreSQL 14
select candidate_id
from 
(
SELECT candidate_id,
sum(case 
when skill = 'Python' then 1
when skill = 'Tableau' then 1
when skill = 'PostgreSQL' then 1
else 0
end ) as points
FROM candidates
group by candidate_id
)t 
where points = 3
--Questions said that there are no duplicates in canditates table

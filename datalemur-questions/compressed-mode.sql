/*
Description- You're given a table containing the item count for each order on Alibaba,
along with the frequency of orders that have the same item count. 
Write a query to retrieve the mode of the order occurrences. 
Additionally, if there are multiple item counts with the same mode, 
the results should be sorted in ascending order.

Link - https://datalemur.com/questions/alibaba-compressed-mode
*/
--Postgre SQL 14

select item_count as mode
from 
  (
  SELECT *,
  dense_rank() over(order by order_occurrences DESC) as dr
  FROM items_per_order
  )t 
where dr = 1
order by item_count  


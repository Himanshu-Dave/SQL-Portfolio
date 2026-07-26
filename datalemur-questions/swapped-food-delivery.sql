/*
Description- Zomato is a leading online food delivery service that connects users
with various restaurants and cuisines, allowing them to browse menus, place orders,
and get meals delivered to their doorsteps.

Recently, Zomato encountered an issue with their delivery system. 
Due to an error in the delivery driver instructions, each item's order was swapped
with the item in the subsequent row. As a data analyst, you're asked to correct
this swapping error and return the proper pairing of order ID and item.

If the last item has an odd order ID, it should remain as the last item in the corrected data. 
For example, if the last item is Order ID 7 Tandoori Chicken, then it should
remain as Order ID 7 in the corrected data.

In the results, return the correct pairs of order IDs and items.

Link - https://datalemur.com/questions/sql-swapped-food-delivery
*/
--Postgre SQL 14

WITH main AS(
  SELECT * ,
  lag(item) over(order by order_id rows between 1 PRECEDING and current row) as lagged,
  lead(item) over(order by order_id rows between 1 PRECEDING and current row) as leaded
  FROM orders 
),
cte1 AS (
select *
from main 
where order_id%2 = 1
),
cte2 AS (
select *
from main 
where order_id%2 = 0
),
cte3 AS(
select *,
case when order_id = (select max(order_id) from orders) and order_id % 2 = 1 then item
else ''
end as last_row
from main 
)

select m.order_id,
coalesce(c1.leaded  , '') || coalesce(c2.lagged,'') || c3.last_row as item
from main m 
left join cte1 c1 on m.order_id = c1.order_id
left join cte2 c2 on m.order_id = c2.order_id
left join cte3 c3 on m.order_id = c3.order_id
order by order_id


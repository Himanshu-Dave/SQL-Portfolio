/*
Description- The Bloomberg terminal is the go-to resource for financial professionals,
offering convenient access to a wide array of financial datasets.
As a Data Analyst at Bloomberg, you have access to historical data on stock performance.

Currently, you're analyzing the highest and lowest open prices for each FAANG stock by month over the years.

For each FAANG stock, display the ticker symbol, the month 
and year ('Mon-YYYY') with the corresponding highest and lowest open prices
(refer to the Example Output format). Ensure that the results are sorted by ticker symbol.

Link - https://datalemur.com/questions/sql-bloomberg-stock-min-max-1
*/
--Postgre SQL 14

with cte1 as (
  select *,
  TO_CHAR(date, 'Mon-YYYY') AS highest_mth
  from (
        select *,
        row_number() over(partition by ticker order by open DESC) as rn
        from stock_prices 
  )t
  where rn = 1
  order by open DESC
),
cte2 as (
  select *,
  TO_CHAR(date, 'Mon-YYYY') AS lowest_mth
  from (
        select *,
        row_number() over(partition by ticker order by open) as rn
        from stock_prices 
  )t
  where rn = 1
  order by open
)

SELECT ticker,
max(highest_mth) ,
max(highest_open),
min(lowest_mth),
min(lowest_open)
from( select
  s.ticker,
  max(c1.highest_mth) as highest_mth,
  max(s.open)  over(PARTITION BY s.ticker) as highest_open,
  max(c2.lowest_mth) as lowest_mth,
  min(s.open)  over(PARTITION BY s.ticker) as lowest_open
  FROM stock_prices s
  left join cte1 c1 on s.ticker = c1.ticker
  left join cte2 c2 on s.ticker = c2.ticker
  group by s.ticker,s.open
)t
group by ticker
ORDER BY ticker

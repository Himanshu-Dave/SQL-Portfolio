/*
Description- A phone call is considered an international call when the person
calling is in a different country than the person receiving the call.

What percentage of phone calls are international? Round the result to 1 decimal.

Link - https://datalemur.com/questions/international-call-percentage
*/
--Postgre SQL 14

with phone_country as (
    select distinct caller_id as phone_id, country_id
    from phone_info
)

select
    round(
        count(case when pc1.country_id != pc2.country_id then 1 end) * 100.0
        / count(*),
        1
    ) as international_calls_pct
from phone_calls c
left join phone_country pc1 on c.caller_id = pc1.phone_id
left join phone_country pc2 on c.receiver_id = pc2.phone_id




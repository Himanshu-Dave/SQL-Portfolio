/*
Description- You're given two tables containing data on Spotify users'
streaming activity: songs_history which has historical streaming data,
and songs_weekly which has data from the current week.

Write a query that outputs the user ID, song ID, and cumulative count
of song plays up to August 4th, 2022, sorted in descending order.

Assume that there may be new users or songs in the songs_weekly table
that are not present in the songs_history table.

Link - https://datalemur.com/questions/spotify-streaming-history
*/
--Postgre SQL 14


select
user_id,
song_id,
summed as song_plays
from(
    select *,
    sum(song_plays) over(partition by user_id, song_id) as summed,
    row_number() over(partition by user_id, song_id order by song_plays desc) as rn
    from(
        select user_id, song_id, song_plays
        from songs_history
        union all
        select user_id, song_id, count(song_id) as song_plays
        from songs_weekly
        where listen_time <= '2022-08-04 23:59:59'
        group by user_id, song_id
    )a
)t
where rn = 1
order by summed desc

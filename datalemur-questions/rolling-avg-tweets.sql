/*
Description- Given a table of tweet data over a specified time period, 
calculate the 3-day rolling average of tweets for each user. 
Output the user ID, tweet date, and rolling averages rounded to 2 decimal places.

Link - https://datalemur.com/questions/rolling-average-tweets
*/
--Postgre SQL 14

SELECT user_id,
tweet_date,
round(avg(tweet_count) over (partition by user_id order by tweet_date rows between 2 PRECEDING and current row) ,2) as rolling_avg_3d
FROM tweets







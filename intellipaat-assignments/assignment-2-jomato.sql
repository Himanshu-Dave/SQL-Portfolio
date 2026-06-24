-- ============================================================
-- SQL Mandatory Assignment 2 | Intellipaat x IIT Indore
-- Dataset  : Jomato – Restaurant Analytics
-- Tables   : Restaurants
-- Author   : Himanshu Dave
-- ============================================================


-- ============================================================
-- Q1. User-defined function to stuff 'Chicken' into 'Quick Bites'
--     Result: 'Quick Chicken Bites'
-- ============================================================

create function dbo.fn_stuffchicken
(
    @RestaurantType VARCHAR(50)
)
returns VARCHAR(100)
as
begin
    return STUFF(@RestaurantType, 6, 0, ' Chicken');
end;

-- Test the function
select dbo.fn_stuffchicken('Quick Bites') AS NewType;


-- ============================================================
-- Q2. Restaurant name and cuisine type with the maximum rating
--     Using the function created in Q1
-- ============================================================

select
    RestaurantName,
    dbo.fn_stuffchicken(RestaurantType) as ModifiedType,
    CuisinesType,
    Rating
FROM Restaurants
where Rating = (select MAX(Rating) from Restaurants);


-- ============================================================
-- Q3. Rating Status column using CASE
--     Excellent > 4 | Good > 3.5 | Average > 3 | Bad < 3
-- ============================================================

SELECT *,
    case
    when Rating > 4   then 'Excellent'
    WHEN Rating > 3.5 THEN 'Good'
    when Rating > 3   then 'Average'
    else 'Bad'
    end as RatingStatus
from Restaurants
order by Rating DESC;


-- ============================================================
-- Q4. CEIL, FLOOR, ABS of Rating + current date parts
-- ============================================================

select *,
    floor(Rating) AS FloorRating,
    ABS(Rating) as AbsoluteRating,
    ceiling(Rating) AS CeilRating,
    GETDATE() as CurrentDate,
    YEAR(GETDATE()) AS CurrentYear,
    datename(MONTH, GETDATE()) AS CurrentMonth,
    day(GETDATE()) as CurrentDay
FROM Restaurants;


-- ============================================================
-- Q5. Restaurant type and total average cost using ROLLUP
--     ROLLUP adds a grand total row at the end
-- ============================================================

select
    RestaurantType,
    sum(AverageCost) as TotalAvgCost
from Restaurants
GROUP BY rollup(RestaurantType);


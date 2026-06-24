-- ============================================================
-- SQL Mandatory Assignment 3 | Intellipaat x IIT Indore
-- Dataset  : Jomato – Restaurant Analytics (Advanced)
-- Tables   : Restaurants
-- Author   : Himanshu Dave
-- ============================================================


-- ============================================================
-- Q1. Stored Procedure – restaurants where table booking is not zero
-- ============================================================

CREATE PROCEDURE sp_GetRestaurantsWithBooking
as
begin
    select RestaurantName, RestaurantType, Cuisine
    FROM Restaurants
    where TableBooking <> 0;
end;

-- Execute
exec sp_GetRestaurantsWithBooking;


-- ============================================================
-- Q2. Transaction – update Cuisine 'Cafe' to 'Cafeteria', then ROLLBACK
-- ============================================================

BEGIN TRANSACTION;

    update Restaurants
    SET Cuisine = 'Cafeteria'
    where Cuisine = 'Cafe';

    -- Check result before rollback
    select RestaurantName, Cuisine
    from Restaurants
    WHERE Cuisine IN ('Cafe', 'Cafeteria');

ROLLBACK TRANSACTION;

-- Verifying the rollback restored original values
select RestaurantName, Cuisine
from Restaurants
where Cuisine IN ('Cafe', 'Cafeteria');


-- ============================================================
-- Q3. ROW_NUMBER – top 5 areas with highest average rating
--     NOTE: must aggregate by Area first, then rank
-- ============================================================

with RankedAreas as (
    SELECT
        Area,
        avg(Rating)                                     AS AvgRating,
        row_number() over (order by avg(Rating) DESC)   as RowNum
    from Restaurants
    GROUP BY Area
)
select Area, AvgRating
FROM RankedAreas
where RowNum <= 5;


-- ============================================================
-- Q4. WHILE loop – print numbers 1 to 50
-- ============================================================

DECLARE @i INT = 1;
while @i <= 50
begin
    print @i;
    set @i = @i + 1;
end;


-- ============================================================
-- Q5. VIEW – Top 5 restaurants by highest rating
-- ============================================================

create view TopRatingRestaurants as
SELECT TOP 5
    RestaurantName,
    Area,
    Rating
from Restaurants
order by Rating DESC;

-- Query the view
select * FROM TopRatingRestaurants;


-- ============================================================
-- Q6. TRIGGER – print message on every new INSERT
-- ============================================================

CREATE TRIGGER trg_NewRestaurant
ON Restaurants
AFTER INSERT
as
begin
    print 'A new restaurant record has been inserted!';
end;


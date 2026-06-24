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
AS
BEGIN
    SELECT RestaurantName, RestaurantType, Cuisine
    FROM Restaurants
    WHERE TableBooking <> 0;
END;

-- Execute
EXEC sp_GetRestaurantsWithBooking;


-- ============================================================
-- Q2. Transaction – update Cuisine 'Cafe' to 'Cafeteria', then ROLLBACK
-- ============================================================

BEGIN TRANSACTION;

    UPDATE Restaurants
    SET Cuisine = 'Cafeteria'
    WHERE Cuisine = 'Cafe';

    -- Check result before rollback
    SELECT RestaurantName, Cuisine
    FROM Restaurants
    WHERE Cuisine IN ('Cafe', 'Cafeteria');

ROLLBACK TRANSACTION;
-- Verifying the rollback restored original values
SELECT RestaurantName, Cuisine
FROM Restaurants
WHERE Cuisine IN ('Cafe', 'Cafeteria');


-- ============================================================
-- Q3. ROW_NUMBER – top 5 areas with highest average rating
--     NOTE: must aggregate by Area first, then rank
-- ============================================================

WITH RankedAreas AS (
    SELECT
        Area,
        AVG(Rating)                                     AS AvgRating,
        ROW_NUMBER() OVER (ORDER BY AVG(Rating) DESC)   AS RowNum
    FROM Restaurants
    GROUP BY Area
)
SELECT Area, AvgRating
FROM RankedAreas
WHERE RowNum <= 5;


-- ============================================================
-- Q4. WHILE loop – print numbers 1 to 50
-- ============================================================

DECLARE @i INT = 1;
WHILE @i <= 50
BEGIN
    PRINT @i;
    SET @i = @i + 1;
END;


-- ============================================================
-- Q5. VIEW – Top 5 restaurants by highest rating
-- ============================================================

CREATE VIEW TopRatingRestaurants AS
SELECT TOP 5
    RestaurantName,
    Area,
    Rating
FROM Restaurants
ORDER BY Rating DESC;

-- Query the view
SELECT * FROM TopRatingRestaurants;


-- ============================================================
-- Q6. TRIGGER – print message on every new INSERT
-- ============================================================

CREATE TRIGGER trg_NewRestaurant
ON Restaurants
AFTER INSERT
AS
BEGIN
    PRINT 'A new restaurant record has been inserted!';
END;

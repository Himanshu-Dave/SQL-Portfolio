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

CREATE FUNCTION dbo.fn_stuffchicken
(
    @RestaurantType VARCHAR(50)
)
RETURNS VARCHAR(100)
AS
BEGIN
    RETURN STUFF(@RestaurantType, 6, 0, ' Chicken');
END;

-- Test the function
SELECT dbo.fn_stuffchicken('Quick Bites') AS NewType;


-- ============================================================
-- Q2. Restaurant name and cuisine type with the maximum rating
--     Using the function created in Q1
-- ============================================================

SELECT
    RestaurantName,
    dbo.fn_stuffchicken(RestaurantType) AS ModifiedType,
    CuisinesType,
    Rating
FROM Restaurants
WHERE Rating = (SELECT MAX(Rating) FROM Restaurants);


-- ============================================================
-- Q3. Rating Status column using CASE
--     Excellent > 4 | Good > 3.5 | Average > 3 | Bad < 3
-- ============================================================

SELECT *,
    CASE
        WHEN Rating > 4   THEN 'Excellent'
        WHEN Rating > 3.5 THEN 'Good'
        WHEN Rating > 3   THEN 'Average'
        ELSE 'Bad'
    END AS RatingStatus
FROM Restaurants
ORDER BY Rating DESC;


-- ============================================================
-- Q4. CEIL, FLOOR, ABS of Rating + current date parts
-- ============================================================

SELECT *,
    FLOOR(Rating)                    AS FloorRating,
    ABS(Rating)                      AS AbsoluteRating,
    CEILING(Rating)                  AS CeilRating,
    GETDATE()                        AS CurrentDate,
    YEAR(GETDATE())                  AS CurrentYear,
    DATENAME(MONTH, GETDATE())       AS CurrentMonth,
    DAY(GETDATE())                   AS CurrentDay
FROM Restaurants;


-- ============================================================
-- Q5. Restaurant type and total average cost using ROLLUP
--     ROLLUP adds a grand total row at the end
-- ============================================================

SELECT
    RestaurantType,
    SUM(AverageCost) AS TotalAvgCost
FROM Restaurants
GROUP BY ROLLUP(RestaurantType);

-- ============================================================
-- SQL Mandatory Assignment 1 | Intellipaat x IIT Indore
-- Dataset  : ABC Fashion – Sales Order Processing System
-- Tables   : Salesman, Customer, Orders
-- Author   : Himanshu Dave
-- ============================================================


-- ============================================================
-- Q1. Insert a new record in the Orders table
-- ============================================================

insert INTO Orders (OrderId, CustomerId, SalesmanId, OrderDate, Amount)
VALUES (5002, 3456, 104, '2022-12-12', 650);


-- ============================================================
-- Q2. Add Constraints
-- ============================================================

-- 2a. PRIMARY KEY on SalesmanId in Salesman table
ALTER TABLE Salesman
alter column SalesmanId INT not null;

ALTER TABLE Salesman
ADD CONSTRAINT pk_salesman PRIMARY KEY (SalesmanId);

-- 2b. DEFAULT constraint for City column in Salesman table
alter table Salesman
ADD CONSTRAINT df_city default 'California' FOR City;

-- 2c. FOREIGN KEY on SalesmanId in Customer table → references Salesman
ALTER TABLE Customer
add constraint fk_customer_salesman
FOREIGN KEY (SalesmanId) references Salesman(SalesmanId);

-- 2d. NOT NULL on CustomerName in Customer table
alter table Customer
ALTER COLUMN CustomerName VARCHAR(50) not null;


-- ============================================================
-- Q3. Customers whose name ends with 'N' AND PurchaseAmount > 500
-- ============================================================

select *
FROM Customer
where CustomerName LIKE '%N'
  and PurchaseAmount > 500;


-- ============================================================
-- Q4. SET Operators on SalesmanId
-- ============================================================

-- 4a. UNION – unique SalesmanId values across both tables
SELECT SalesmanId from Orders
union
SELECT SalesmanId FROM Salesman;

-- 4b. UNION ALL – includes duplicates across both tables
select SalesmanId FROM Orders
UNION ALL
select SalesmanId from Salesman;


-- ============================================================
-- Q5. Matching data: OrderDate, SalesmanName, CustomerName,
--     Commission, City where PurchaseAmount is between 500-1500
-- ============================================================

SELECT
    o.OrderDate,
    s.SalesmanName,
    c.CustomerName,
    s.Commission,
    s.City
from Orders o
left join Customer c ON o.CustomerId = c.CustomerId
LEFT JOIN Salesman s on o.SalesmanId = s.SalesmanId
WHERE c.PurchaseAmount >= 500
  and c.PurchaseAmount <= 1500;


-- ============================================================
-- Q6. RIGHT JOIN – all results from Salesman and Orders table
-- ============================================================

select *
FROM Orders o
right join Salesman s ON o.SalesmanId = s.SalesmanId;

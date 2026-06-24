-- ============================================================
-- SQL Case Study 2 | Intellipaat x IIT Indore
-- Problem  : Employee Database Management (HR Schema)
-- Tables   : LOCATION, DEPARTMENT, JOB, EMPLOYEE
-- Schema   : LOCATION(1) -> DEPARTMENT(M) -> EMPLOYEE(M) -> JOB(1)
-- Author   : Himanshu Dave
-- ============================================================

-- ============================================================
-- TABLE CREATION
-- ============================================================

CREATE TABLE LOCATION (
    Location_ID INT PRIMARY KEY,
    City        VARCHAR(50)
);

CREATE TABLE DEPARTMENT (
    Department_Id INT PRIMARY KEY,
    Name          VARCHAR(50),
    Location_Id   INT FOREIGN KEY REFERENCES LOCATION(Location_ID)
);

CREATE TABLE JOB (
    Job_ID      INT PRIMARY KEY,
    Designation VARCHAR(50)
);

CREATE TABLE EMPLOYEE (
    Employee_Id   INT PRIMARY KEY,
    Last_Name     VARCHAR(50),
    First_Name    VARCHAR(50),
    Middle_Name   VARCHAR(5),
    Job_Id        INT FOREIGN KEY REFERENCES JOB(Job_ID),
    Manager_Id    INT,
    Hire_Date     DATE,
    Salary        INT,
    Comm          INT,
    Department_Id INT FOREIGN KEY REFERENCES DEPARTMENT(Department_Id)
);

-- ============================================================
-- SAMPLE DATA
-- ============================================================

INSERT INTO LOCATION VALUES (122,'New York'),(123,'Dallas'),(124,'Chicago'),(167,'Boston');

INSERT INTO DEPARTMENT VALUES (10,'Accounting',122),(20,'Sales',124),(30,'Research',123),(40,'Operations',167);

INSERT INTO JOB VALUES (667,'Clerk'),(668,'Staff'),(669,'Analyst'),(670,'Sales Person'),(671,'Manager'),(672,'President');

INSERT INTO EMPLOYEE VALUES
(7369,'Smith',  'John',   'Q', 667, NULL, '1984-12-17', 800,  NULL, 20),
(7499,'Allen',  'Kevin',  'J', 670, NULL, '1985-02-20', 1600, 300,  30),
(755, 'Doyle',  'Jean',   'K', 671, NULL, '1985-04-04', 2850, NULL, 30),
(756, 'Dennis', 'Lynn',   'S', 671, NULL, '1985-05-15', 2750, NULL, 30),
(757, 'Baker',  'Leslie', 'D', 671, NULL, '1985-06-10', 2200, NULL, 40),
(7521,'Wark',   'Cynthia','D', 670, NULL, '1985-02-22', 1250, 50,   30);


-- ============================================================
-- SIMPLE QUERIES
-- ============================================================

-- 1. All employee details
select * FROM EMPLOYEE;

-- 2. All department details
SELECT * from DEPARTMENT;

-- 3. All job details
select * FROM JOB;

-- 4. All locations
SELECT * from LOCATION;

-- 5. First Name, Last Name, Salary, Commission for all employees
select First_Name, Last_Name, Salary, Comm from EMPLOYEE;

-- 6. Employee ID, Last Name, Department ID with aliases
SELECT
    Employee_Id   AS [ID of the Employee],
    Last_Name     as [Name of the Employee],
    Department_Id AS Dep_Id
from EMPLOYEE;

-- 7. Annual salary with employee name
select
    Salary * 12                                      as Annual_Salary,
    First_Name + ' ' + Middle_Name + ' ' + Last_Name AS Name
FROM EMPLOYEE;


-- ============================================================
-- WHERE CLAUSE
-- ============================================================

-- 1. Details about 'Smith'
select * FROM EMPLOYEE WHERE Last_Name = 'Smith';

-- 2. Employees in department 20
SELECT * from EMPLOYEE where Department_Id = 20;

-- 3. Employees earning salary between 2000 and 3000
select * FROM EMPLOYEE where Salary BETWEEN 2000 AND 3000;

-- 4. Employees in department 10 or 20
SELECT * from EMPLOYEE WHERE Department_Id IN (10, 20);

-- 5. Employees NOT in department 10 or 30
select * FROM EMPLOYEE WHERE Department_Id NOT IN (10, 30);

-- 6. Employees whose first name starts with 'L'
SELECT * FROM EMPLOYEE where First_Name LIKE 'L%';

-- 7. Employees whose first name starts with 'L' and ends with 'E'
select * from EMPLOYEE WHERE First_Name LIKE 'L%E';

-- 8. Employees whose first name is 4 characters and starts with 'J'
SELECT * FROM EMPLOYEE where First_Name LIKE 'J___';

-- 9. Employees in department 30 with salary > 2500
select * from EMPLOYEE WHERE Department_Id = 30 AND Salary > 2500;

-- 10. Employees not receiving commission (COMM is NULL)
SELECT * FROM EMPLOYEE where Comm IS NULL;


-- ============================================================
-- ORDER BY CLAUSE
-- ============================================================

-- 1. Employee ID and Last Name in ASCENDING order by Employee ID
select Employee_Id, Last_Name
from EMPLOYEE
ORDER BY Employee_Id ASC;

-- 2. Employee ID and full name in descending order by salary
SELECT
    Employee_Id,
    First_Name + ' ' + Middle_Name + ' ' + Last_Name as Name
FROM EMPLOYEE
order by Salary DESC;

-- 3. All employee details in ascending order by Last Name
select * from EMPLOYEE ORDER BY Last_Name ASC;

-- 4. All employee details: Last Name ASC, then Department ID DESC
SELECT * FROM EMPLOYEE order by Last_Name ASC, Department_Id DESC;


-- ============================================================
-- GROUP BY AND HAVING CLAUSE
-- ============================================================

-- 1. Department-wise MAX, MIN, AVG salary
select
    Department_Id,
    MAX(Salary) as Max_Salary,
    min(Salary) AS Min_Salary,
    AVG(Salary) as Avg_Salary
FROM EMPLOYEE
group by Department_Id;

-- 2. Job-wise MAX, MIN, AVG salary
SELECT
    Job_Id,
    MAX(Salary) AS Max_Salary,
    MIN(Salary) as Min_Salary,
    avg(Salary) AS Avg_Salary
from EMPLOYEE
GROUP BY Job_Id;

-- 3. Number of employees who joined each month (ascending)
select
    DATEPART(MONTH, Hire_Date) as Joining_Month,
    COUNT(*)                   AS No_Of_Employees
FROM EMPLOYEE
group by DATEPART(MONTH, Hire_Date)
order by DATEPART(MONTH, Hire_Date);

-- 4. Number of employees for each month and year (ascending)
SELECT
    DATEPART(YEAR,  Hire_Date) AS Joining_Year,
    datepart(MONTH, Hire_Date) as Joining_Month,
    count(*)                   AS No_Of_Employees
from EMPLOYEE
GROUP BY DATEPART(YEAR, Hire_Date), DATEPART(MONTH, Hire_Date)
ORDER BY DATEPART(YEAR, Hire_Date), DATEPART(MONTH, Hire_Date);

-- 5. Department IDs with at least 4 employees
select Department_Id
FROM EMPLOYEE
group by Department_Id
HAVING COUNT(*) >= 4;

-- 6. Employees who joined in February
SELECT COUNT(*) as No_Of_Employees
from EMPLOYEE
GROUP BY DATEPART(MONTH, Hire_Date)
having DATEPART(MONTH, Hire_Date) = 2;

-- 7. Employees who joined in May or June
select count(*) AS No_Of_Employees
FROM EMPLOYEE
group by DATEPART(MONTH, Hire_Date)
HAVING DATEPART(MONTH, Hire_Date) IN (5, 6);

-- 8. Employees who joined in 1985
SELECT COUNT(*) AS No_Of_Employees
from EMPLOYEE
GROUP BY DATEPART(YEAR, Hire_Date)
having DATEPART(YEAR, Hire_Date) = 1985;

-- 9. Employees who joined each month in 1985
select
    DATEPART(MONTH, Hire_Date) AS Joining_Month,
    COUNT(*)                   as No_Of_Employees
FROM EMPLOYEE
group by DATEPART(YEAR, Hire_Date), DATEPART(MONTH, Hire_Date)
HAVING DATEPART(YEAR, Hire_Date) = 1985;

-- 10. Employees who joined in April 1985
SELECT count(*) as No_Of_Employees
from EMPLOYEE
GROUP BY DATEPART(YEAR, Hire_Date), DATEPART(MONTH, Hire_Date)
having DATEPART(YEAR, Hire_Date) = 1985
   AND DATEPART(MONTH, Hire_Date) = 4;

-- 11. Department ID with >= 3 employees joining in April 1985
select Department_Id
FROM EMPLOYEE
group by Department_Id, DATEPART(YEAR, Hire_Date), DATEPART(MONTH, Hire_Date)
HAVING DATEPART(YEAR,  Hire_Date) = 1985
   AND DATEPART(MONTH, Hire_Date) = 4
   AND count(*) >= 3;


-- ============================================================
-- JOINS
-- ============================================================

-- 1. Employees with their department names
select e.First_Name, d.Name as Department_Name
FROM EMPLOYEE e
join DEPARTMENT d ON d.Department_Id = e.Department_Id;

-- 2. Employees with their designations
SELECT e.Employee_Id, e.First_Name, e.Job_Id, j.Designation
from EMPLOYEE e
JOIN JOB j ON j.Job_ID = e.Job_Id;

-- 3. Employees with department name and city
select
    e.Employee_Id, e.First_Name,
    d.Name as Department_Name,
    l.City
from EMPLOYEE e
JOIN DEPARTMENT d ON d.Department_Id = e.Department_Id
join LOCATION   l ON l.Location_ID   = d.Location_Id;

-- 4. Employee count per department (with department name)
SELECT
    e.Employee_Id,
    e.First_Name,
    d.Name                                          as Department_Name,
    count(*) OVER (PARTITION BY d.Name)             AS No_Of_Employees
FROM EMPLOYEE e
join DEPARTMENT d ON d.Department_Id = e.Department_Id;

-- 5. Employees in the Sales department with count
select
    e.Employee_Id,
    e.First_Name,
    d.Name                   AS Department_Name,
    COUNT(*) OVER ()         as No_Of_Employees
from EMPLOYEE e
JOIN DEPARTMENT d ON d.Department_Id = e.Department_Id
WHERE d.Name = 'Sales';

-- 6. Departments with >= 3 employees, names in ascending order
SELECT Department_Name, MAX(No_Of_Employees) as No_Of_Employees
FROM (
    select
        e.Employee_Id,
        d.Name                                      AS Department_Name,
        COUNT(*) OVER (PARTITION BY d.Name)         as No_Of_Employees
    from EMPLOYEE e
    join DEPARTMENT d ON d.Department_Id = e.Department_Id
) t
where No_Of_Employees >= 3
GROUP BY Department_Name
order by Department_Name;

-- 7. Number of employees working in 'Dallas'
select l.City, max(No_Of_Employees) AS No_Of_Employees
FROM (
    SELECT
        e.Employee_Id,
        l.City,
        COUNT(*) OVER (PARTITION BY l.City) as No_Of_Employees
    FROM EMPLOYEE e
    join DEPARTMENT d ON d.Department_Id = e.Department_Id
    JOIN LOCATION   l ON l.Location_ID   = d.Location_Id
    where l.City = 'Dallas'
) t
JOIN LOCATION l ON l.City = t.City
group by l.City;

-- 8. All employees in Sales or Operations departments
SELECT e.First_Name, d.Name AS Department_Name
from EMPLOYEE e
join DEPARTMENT d ON d.Department_Id = e.Department_Id
WHERE d.Name IN ('Sales', 'Operations');


-- ============================================================
-- CONDITIONAL STATEMENTS (CASE)
-- ============================================================

-- Grade bands: A >= 2400 | B 1600-2399 | C 800-1599 | D <= 800

-- 1. Employee details with salary grade column
select *,
    CASE
        WHEN Salary <= 800  THEN 'D'
        WHEN Salary < 1600  THEN 'C'
        WHEN Salary < 2400  THEN 'B'
        ELSE 'A'
    END as Salary_Grade
from EMPLOYEE;

-- 2. Employee count per salary grade
SELECT
    case
        WHEN Salary <= 800  THEN 'D'
        WHEN Salary < 1600  THEN 'C'
        WHEN Salary < 2400  THEN 'B'
        ELSE 'A'
    end AS Salary_Grade,
    COUNT(*) as No_Of_Employees
FROM EMPLOYEE
GROUP BY
    CASE
        WHEN Salary <= 800  THEN 'D'
        WHEN Salary < 1600  THEN 'C'
        WHEN Salary < 2400  THEN 'B'
        ELSE 'A'
    END;

-- 3. Salary grade and count for employees earning between 2000 and 5000
select
    CASE
        WHEN Salary <= 800  THEN 'D'
        WHEN Salary < 1600  THEN 'C'
        WHEN Salary < 2400  THEN 'B'
        ELSE 'A'
    END as Salary_Grade,
    count(*) AS No_Of_Employees
from EMPLOYEE
where Salary BETWEEN 2000 AND 5000
group by
    CASE
        WHEN Salary <= 800  THEN 'D'
        WHEN Salary < 1600  THEN 'C'
        WHEN Salary < 2400  THEN 'B'
        ELSE 'A'
    END;


-- ============================================================
-- SUBQUERIES
-- ============================================================

-- 1. Employees who got the maximum salary
SELECT Employee_Id, Last_Name, First_Name, Middle_Name,
       Job_Id, Manager_Id, Hire_Date, Salary, Comm, Department_Id
from (
    select *, MAX(Salary) OVER () as Max_Salary
    FROM EMPLOYEE
) t
where Salary = Max_Salary;

-- 2. Employees working in the Sales department
select e.Employee_Id, e.First_Name, d.Name as Department_Name
FROM EMPLOYEE e
join DEPARTMENT d ON d.Department_Id = e.Department_Id
WHERE d.Name = 'Sales';

-- 3. Employees working as 'Clerk'
SELECT e.*, j.Designation
from EMPLOYEE e
LEFT JOIN JOB j ON e.Job_Id = j.Job_ID
where j.Designation = 'Clerk';

-- 4. Employees living in 'Boston'
select e.*, l.City
FROM EMPLOYEE e
JOIN DEPARTMENT d ON d.Department_Id = e.Department_Id
join LOCATION   l ON l.Location_ID   = d.Location_Id
WHERE l.City = 'Boston';

-- 5. Number of employees in the Sales department
SELECT
    e.*,
    COUNT(*) OVER ()  as No_Of_Employees,
    d.Name            AS Department_Name
from EMPLOYEE e
join DEPARTMENT d ON d.Department_Id = e.Department_Id
WHERE d.Name = 'Sales';

-- 6. Update salaries of Clerks by 10%
UPDATE EMPLOYEE
SET Salary = Salary + (Salary * 0.1)
where Job_Id = 667;

-- 7. Second highest salary employee details (using DENSE_RANK)
select Employee_Id, Last_Name, First_Name, Middle_Name,
       Job_Id, Manager_Id, Hire_Date, Salary, Comm, Department_Id
FROM (
    SELECT *, DENSE_RANK() OVER (order by Salary DESC) AS DR
    from EMPLOYEE
) t
WHERE DR = 2;

-- 8. Employees who earn MORE than every employee in department 30
select *
FROM EMPLOYEE
where Salary > (
    SELECT max(Salary)
    FROM EMPLOYEE
    where Department_Id = 30
);

-- 9. Departments that have NO employees
SELECT d.*
from DEPARTMENT d
LEFT JOIN EMPLOYEE e ON d.Department_Id = e.Department_Id
WHERE e.Employee_Id IS NULL;

-- 10. Employees who earn more than their own department's average salary
select *
FROM (
    SELECT *,
        AVG(Salary) OVER (PARTITION BY Department_Id) as Avg_Dept_Salary
    from EMPLOYEE
) t
where Salary > Avg_Dept_Salary;

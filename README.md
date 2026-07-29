# SQL Portfolio - Himanshu Dave

[![Certificate](https://img.shields.io/badge/Intellipaat-SQL%20Certified-orange)](https://www.intellipaat.com)
[![IIT Indore](https://img.shields.io/badge/In%20collaboration%20with-IIT%20Indore-blue)](https://www.iiti.ac.in)
[![SQL Server](https://img.shields.io/badge/SQL-Server-red)](https://www.microsoft.com/sql-server)
[![T-SQL](https://img.shields.io/badge/Dialect-T--SQL-CC2927)](https://learn.microsoft.com/en-us/sql/t-sql/language-reference)
[![PostgreSQL](https://img.shields.io/badge/SQL-PostgreSQL-blue)](https://www.postgresql.org)
[![DataLemur](https://img.shields.io/badge/Practice-DataLemur-6c5ce7)](https://datalemur.com)
[![LeetCode](https://img.shields.io/badge/Practice-LeetCode-FFA116)](https://leetcode.com)


## Certification

**Intellipaat SQL Course**, in collaboration with IIT Indore
Issued: June 19, 2026 | Certificate ID: `31679-913167-357128`

---

## 📁 Repository Structure

```
sql-portfolio/
│
├── README.md
│
├── intellipaat-assignments/
│   ├── assignment-1-abc-fashion.sql            ← DDL, DML, JOINs, SET operators
│   ├── assignment-2-jomato.sql                 ← UDFs, CASE, Math functions, ROLLUP
│   └── assignment-3-jomato-advanced.sql        ← Stored Procs, Triggers, Views, Transactions
│
├── intellipaat-Case-Studies/
│   ├── case-study-1-sales-analytics.sql        ← 29 queries on a 4200-row fact table
│   └── case-study-2-employee-db.sql            ← Full HR schema + 50+ queries
│
├── 8weeksqlchallenge/
│   ├── case-study-1-dannys-diner/
│   │   └── dannys-diner.sql                    ← Customer spend, popularity, membership behavior, loyalty points
│   │
│   └── case-study-2-pizza-runner/
│       ├── 01-cleaning-customer-orders.sql
│       ├── 02-cleaning-runner-orders.sql
│       ├── 03-pizza-metrics.sql
│       ├── 04-runner-and-customer-experience.sql
│       ├── 05-ingredient-optimisation.sql
│       └── 06-pricing-and-ratings.sql
│
├── datalemur-questions/
│   └── (one .sql file per question, e.g. second-highest-salary.sql, user-retention.sql, ...)
│
└── leetcode-questions.sql                      ← Basic LeetCode problems, T-SQL
```


---

## Assignments Overview

### Assignment 1: ABC Fashion (Sales Order Processing)
**Dataset:** Salesman, Customer, Orders tables
**Topics covered:**
- INSERT, DDL constraints (PRIMARY KEY, FOREIGN KEY, DEFAULT, NOT NULL)
- LIKE patterns, BETWEEN, WHERE filters
- SET operators: UNION, UNION ALL
- Multi-table JOINs (LEFT JOIN, RIGHT JOIN)

### Assignment 2: Jomato Restaurant Analytics
**Dataset:** Restaurants table
**Topics covered:**
- User-defined scalar functions (STUFF for string manipulation)
- CASE-based conditional columns (rating classification)
- Math functions: CEIL, FLOOR, ABS
- Date functions: GETDATE, YEAR, DATENAME, DAY
- ROLLUP for hierarchical aggregation

### Assignment 3: Jomato Restaurant Analytics (Advanced)
**Dataset:** Restaurants table
**Topics covered:**
- Stored Procedures with BEGIN/END
- Transactions with BEGIN TRANSACTION / ROLLBACK
- ROW_NUMBER() window function (ranked by aggregated area rating)
- WHILE loops for procedural logic
- CREATE VIEW for reusable query results
- AFTER INSERT Triggers for automated messaging

---

## Intellipaat Case Studies

### Case Study 1: Sales & Profit Analytics
**Dataset:** FactTable (4,200 rows) + ProductTable (13 rows) + LocationTable (156 rows)
**29 queries covering:**
- Aggregate functions: SUM, COUNT, MAX, MIN, AVG
- Multi-table JOINs across fact and dimension tables
- DENSE_RANK for gap-free sales ranking
- ROLLUP for weekly hierarchical sales totals
- Stored Procedures (parameterized product type filter)
- Table-valued User-defined Functions
- Transactions with ROLLBACK (undo product type change)
- UNION and INTERSECT set operators
- CASE-based Profit/Loss classification
- DELETE and UPDATE operations

### Case Study 2: Employee Database Management
**Schema:** LOCATION to DEPARTMENT to EMPLOYEE, joined with JOB
**50+ queries covering:**
- Full schema creation with FK constraints
- WHERE clause: LIKE, BETWEEN, IN, NOT IN, IS NULL
- ORDER BY (single and multi-column)
- GROUP BY + HAVING for date-based hire analysis
- Multi-table JOINs (2-3 table chains)
- Window functions: COUNT() OVER (PARTITION BY), AVG() OVER (PARTITION BY), DENSE_RANK()
- Correlated logic: employees earning above their department's average
- Subqueries: max salary, second highest salary
- CASE-based salary grading system

---

## 8 Week SQL Challenge (Danny Ma)

A set of business-scenario case studies built around realistic (if fictional) companies, each with its own schema and a run of practical analytics questions. A step up in complexity from the Intellipaat assignments since the questions build on each other and often need multi-step CTEs rather than single queries.

### Case Study 1: Danny's Diner
**Scenario:** A small restaurant wants to understand customer visiting patterns, spending habits, and favorite menu items to decide whether to expand its loyalty program.
**Covers:**
- Total spend and visit frequency per customer
- Most popular menu item overall, and per customer
- Ordering behavior before vs. after a customer joins the membership program
- A points-based loyalty scoring system based on order value and membership status

### Case Study 2: Pizza Runner
**Scenario:** A pizza delivery startup needs its messy, inconsistently formatted order and runner data cleaned up before it can answer basic operational questions about deliveries, ingredients, and pricing.

| File | Section | Covers |
|---|---|---|
| `01-cleaning-customer-orders.sql` | Data Cleaning | Standardizing null/blank handling and formatting in the customer orders table |
| `02-cleaning-runner-orders.sql` | Data Cleaning | Standardizing distance, duration, and cancellation fields in the runner orders table |
| `03-pizza-metrics.sql` | A. Pizza Metrics | Order volume, delivery counts per runner, pizza type breakdowns, customization tracking, order timing patterns |
| `04-runner-and-customer-experience.sql` | B. Runner and Customer Experience | Runner sign-ups by week, pickup/delivery timing, distance and speed per runner, delivery success rates |
| `05-ingredient-optimisation.sql` | C. Ingredient Optimisation | Standard toppings per pizza, most common extras/exclusions, full order-item generation, total ingredient usage |
| `06-pricing-and-ratings.sql` | D. Pricing and Ratings | Revenue calculation, a custom-designed ratings table, combined delivery/rating metrics, net profit after runner pay, menu-expansion schema exercise |

---

## DataLemur Questions

A set of medium-difficulty practice questions from [DataLemur](https://datalemur.com), one `.sql` file per question, each with the original problem description and source link included as a comment header. Written in PostgreSQL, since DataLemur doesn't offer a T-SQL option. Covers window functions (ROW_NUMBER, RANK, DENSE_RANK), running totals, percentage and ratio calculations, gaps-and-islands style consecutive-day and consecutive-month problems, and multi-table joins.

## LeetCode Questions

Basic LeetCode SQL problems, kept in a single file since each one is short and self-contained. Written in T-SQL, covering the fundamentals: ROW_NUMBER, RANK, DENSE_RANK, LAG/LEAD, running totals, self-joins, and simple aggregation.

---

## SQL Topics Covered

| Category | Topics |
|----------|--------|
| **DDL** | CREATE TABLE, ALTER TABLE, Constraints (PK, FK, DEFAULT, NOT NULL) |
| **DML** | SELECT, INSERT, UPDATE, DELETE |
| **Filtering** | WHERE, BETWEEN, IN, NOT IN, LIKE, IS NULL |
| **Aggregation** | GROUP BY, HAVING, COUNT, SUM, AVG, MAX, MIN |
| **Sorting** | ORDER BY ASC/DESC, multi-column sort |
| **Joins** | INNER JOIN, LEFT JOIN, RIGHT JOIN (2-3 table chains) |
| **Set Ops** | UNION, UNION ALL, INTERSECT |
| **Window Functions** | ROW_NUMBER, RANK, DENSE_RANK, LAG/LEAD, COUNT/SUM/AVG OVER (PARTITION BY) |
| **Subqueries** | Scalar, correlated, nested |
| **Procedural SQL** | Stored Procedures, User-defined Functions (scalar + table-valued) |
| **Advanced** | Transactions + ROLLBACK, Triggers, Views, ROLLUP, WHILE loops, gaps-and-islands patterns |
| **String/Date** | STUFF, STRING_SPLIT, STRING_AGG, SUBSTRING, DATEPART, DATENAME, DATEDIFF, GETDATE |

---

## Environment

- **Microsoft SQL Server (T-SQL)** for assignments, case studies, LeetCode, and the 8 Week SQL Challenge
- **PostgreSQL 14** for the DataLemur questions
- **Tools:** SQL Server Management Studio (SSMS), DataLemur's in-browser editor

---

## Connect

- [LinkedIn](https://www.linkedin.com/in/himanshu-dave-457573371?utm_source=share_via&utm_content=profile&utm_medium=member_android)

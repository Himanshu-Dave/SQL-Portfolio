# SQL Portfolio — Himanshu Dave

[![Certificate](https://img.shields.io/badge/Intellipaat-SQL%20Certified-orange)](https://www.intellipaat.com)
[![IIT Indore](https://img.shields.io/badge/In%20collaboration%20with-IIT%20Indore-blue)](https://www.iiti.ac.in)
[![SQL Server](https://img.shields.io/badge/SQL-Server-red)](https://www.microsoft.com/sql-server)

## 🎓 Certification

**Intellipaat SQL Course** — in collaboration with IIT Indore  
📅 Issued: June 19, 2026 | 🔖 Certificate ID: `31679-913167-357128`

---

## 📁 Repository Structure

```
sql-portfolio/
│
├── README.md
│
├── intellipaat-assignments/
│   ├── assignment-1-abc-fashion.sql        ← DDL, DML, JOINs, SET operators
│   ├── assignment-2-jomato.sql             ← UDFs, CASE, Math functions, ROLLUP
│   └── assignment-3-jomato-advanced.sql    ← Stored Procs, Triggers, Views, Transactions
│
└── intellipaat-case-studies/
    ├── case-study-1-sales-analytics.sql    ← 29 queries on a 4200-row fact table
    └── case-study-2-employee-db.sql        ← Full HR schema + 50+ queries
```

---

## 🗂 Assignments Overview

### Assignment 1 — ABC Fashion (Sales Order Processing)
**Dataset:** Salesman, Customer, Orders tables  
**Topics covered:**
- INSERT, DDL constraints (PRIMARY KEY, FOREIGN KEY, DEFAULT, NOT NULL)
- LIKE patterns, BETWEEN, WHERE filters
- SET operators: UNION, UNION ALL
- Multi-table JOINs (LEFT JOIN, RIGHT JOIN)

### Assignment 2 — Jomato Restaurant Analytics
**Dataset:** Restaurants table  
**Topics covered:**
- User-defined scalar functions (STUFF for string manipulation)
- CASE-based conditional columns (rating classification)
- Math functions: CEIL, FLOOR, ABS
- Date functions: GETDATE, YEAR, DATENAME, DAY
- ROLLUP for hierarchical aggregation

### Assignment 3 — Jomato Restaurant Analytics (Advanced)
**Dataset:** Restaurants table  
**Topics covered:**
- Stored Procedures with BEGIN/END
- Transactions with BEGIN TRANSACTION / ROLLBACK
- ROW_NUMBER() window function (ranked by aggregated area rating)
- WHILE loops for procedural logic
- CREATE VIEW for reusable query results
- AFTER INSERT Triggers for automated messaging

---

## 🗂 Case Studies Overview

### Case Study 1 — Sales & Profit Analytics
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

### Case Study 2 — Employee Database Management
**Schema:** LOCATION → DEPARTMENT → EMPLOYEE ← JOB  
**50+ queries covering:**
- Full schema creation with FK constraints
- WHERE clause: LIKE, BETWEEN, IN, NOT IN, IS NULL
- ORDER BY (single and multi-column)
- GROUP BY + HAVING for date-based hire analysis
- Multi-table JOINs (2–3 table chains)
- Window functions: COUNT() OVER (PARTITION BY), AVG() OVER (PARTITION BY), DENSE_RANK()
- Correlated logic: employees earning above their department's average
- Subqueries: max salary, second highest salary
- CASE-based salary grading system

---

## 🛠 SQL Topics Covered

| Category | Topics |
|----------|--------|
| **DDL** | CREATE TABLE, ALTER TABLE, Constraints (PK, FK, DEFAULT, NOT NULL) |
| **DML** | SELECT, INSERT, UPDATE, DELETE |
| **Filtering** | WHERE, BETWEEN, IN, NOT IN, LIKE, IS NULL |
| **Aggregation** | GROUP BY, HAVING, COUNT, SUM, AVG, MAX, MIN |
| **Sorting** | ORDER BY ASC/DESC, multi-column sort |
| **Joins** | INNER JOIN, LEFT JOIN, RIGHT JOIN (2–3 table chains) |
| **Set Ops** | UNION, UNION ALL, INTERSECT |
| **Window Functions** | ROW_NUMBER, DENSE_RANK, COUNT/AVG OVER (PARTITION BY) |
| **Subqueries** | Scalar, correlated, nested |
| **Procedural SQL** | Stored Procedures, User-defined Functions (scalar + table-valued) |
| **Advanced** | Transactions + ROLLBACK, Triggers, Views, ROLLUP, WHILE loops |
| **String/Date** | STUFF, SUBSTRING, ASCII, DATEPART, DATENAME, GETDATE |

---

## 🔧 Environment

- **Database:** Microsoft SQL Server (T-SQL)
- **Tool:** SQL Server Management Studio (SSMS)

---

## 📬 Connect

- 💼 [LinkedIn](https://www.linkedin.com/in/himanshu-dave-457573371?utm_source=share_via&utm_content=profile&utm_medium=member_android)
- 🐙 [GitHub](https://github.com/YOUR-GITHUB-HERE)

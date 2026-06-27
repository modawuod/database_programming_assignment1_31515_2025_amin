# Library Management System

## Database Programming Assignment I

### CTEs and SQL Window Functions

### Project Description

This project demonstrates the use of Common Table Expressions (CTEs) and SQL Window Functions using a Library Management System database.

### Database Tables

* Books
* Members
* Borrowings

### CTE Queries

* Simple CTE
* Multiple CTEs
* Recursive Query
* CTE with Aggregation
* CTE with JOIN

### SQL Window Functions

* ROW_NUMBER()
* RANK()
* DENSE_RANK()
* PERCENT_RANK()
* SUM() OVER()
* AVG() OVER()
* MIN() OVER()
* MAX() OVER()
* LAG()
* LEAD()
* NTILE()
* CUME_DIST()

## ER Diagram

The ER diagram shows the relationship between the three tables: Books, Members, and Borrowings.

* One member can have many borrowings.
* One book can have many borrowings.
* The Borrowings table connects Members and Books using foreign keys.

![ER Diagram](ER_Diagram)

CREATE TABLE Books (
    book_id NUMBER PRIMARY KEY,
    title VARCHAR2(100) NOT NULL,
    author VARCHAR2(100),
    category VARCHAR2(50),
    copies NUMBER
);

CREATE TABLE Members (
    member_id NUMBER PRIMARY KEY,
    member_name VARCHAR2(100) NOT NULL,
    gender VARCHAR2(10),
    phone VARCHAR2(20)
);

CREATE TABLE Borrowings (
    borrow_id NUMBER PRIMARY KEY,
    member_id NUMBER,
    book_id NUMBER,
    borrow_days NUMBER,
    fine_amount NUMBER,
    CONSTRAINT fk_member FOREIGN KEY (member_id) REFERENCES Members(member_id),
    CONSTRAINT fk_book FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

INSERT INTO Books VALUES (101, 'Database Systems', 'Elmasri', 'Education', 5);
INSERT INTO Books VALUES (102, 'Computer Networks', 'Tanenbaum', 'Networking', 4);
INSERT INTO Books VALUES (103, 'Java Programming', 'Herbert Schildt', 'Programming', 6);
INSERT INTO Books VALUES (104, 'Cybersecurity Basics', 'William Stallings', 'Security', 3);
INSERT INTO Books VALUES (105, 'Web Development', 'Jon Duckett', 'Programming', 7);

INSERT INTO Members VALUES (1, 'Amin Hassan', 'Male', '0788000001');
INSERT INTO Members VALUES (2, 'Yusuf Ali', 'Male', '0788000002');
INSERT INTO Members VALUES (3, 'Aline Uwase', 'Female', '0788000003');
INSERT INTO Members VALUES (4, 'Sarah Omar', 'Female', '0788000004');
INSERT INTO Members VALUES (5, 'Mohamed Adam', 'Male', '0788000005');

INSERT INTO Borrowings VALUES (1, 1, 101, 7, 0);
INSERT INTO Borrowings VALUES (2, 1, 103, 12, 500);
INSERT INTO Borrowings VALUES (3, 2, 102, 5, 0);
INSERT INTO Borrowings VALUES (4, 2, 104, 15, 1000);
INSERT INTO Borrowings VALUES (5, 3, 101, 9, 0);
INSERT INTO Borrowings VALUES (6, 3, 105, 14, 700);
INSERT INTO Borrowings VALUES (7, 4, 102, 6, 0);
INSERT INTO Borrowings VALUES (8, 4, 103, 10, 300);
INSERT INTO Borrowings VALUES (9, 5, 104, 18, 1500);
INSERT INTO Borrowings VALUES (10, 5, 105, 8, 0);

COMMIT;

-- Simple CTE
WITH High_Fines AS (
    SELECT member_id, book_id, borrow_days, fine_amount
    FROM Borrowings
    WHERE fine_amount >= 500
)
SELECT *
FROM High_Fines;

-- Multiple CTEs
WITH Borrowed_Books AS (
    SELECT member_id, fine_amount
    FROM Borrowings
),
Member_Total_Fines AS (
    SELECT member_id, SUM(fine_amount) AS total_fine
    FROM Borrowed_Books
    GROUP BY member_id
)
SELECT *
FROM Member_Total_Fines;

-- Recursive Query in Oracle 11g
SELECT LEVEL AS day_number
FROM dual
CONNECT BY LEVEL <= 7;

-- CTE with Aggregation
WITH Book_Statistics AS (
    SELECT book_id,
           AVG(borrow_days) AS average_days,
           MIN(borrow_days) AS minimum_days,
           MAX(borrow_days) AS maximum_days
    FROM Borrowings
    GROUP BY book_id
)
SELECT *
FROM Book_Statistics;

-- CTE with JOIN
WITH Borrowing_Details AS (
    SELECT m.member_name,
           b.title,
           b.category,
           br.borrow_days,
           br.fine_amount
    FROM Borrowings br
    JOIN Members m ON br.member_id = m.member_id
    JOIN Books b ON br.book_id = b.book_id
)
SELECT *
FROM Borrowing_Details;

-- ROW_NUMBER()
SELECT member_id, book_id, borrow_days, fine_amount,
       ROW_NUMBER() OVER (ORDER BY fine_amount DESC) AS row_num
FROM Borrowings;

-- RANK()
SELECT member_id, book_id, borrow_days, fine_amount,
       RANK() OVER (ORDER BY fine_amount DESC) AS fine_rank
FROM Borrowings;

-- DENSE_RANK()
SELECT member_id, book_id, borrow_days, fine_amount,
       DENSE_RANK() OVER (ORDER BY fine_amount DESC) AS dense_rank
FROM Borrowings;

-- PERCENT_RANK()
SELECT member_id, book_id, borrow_days, fine_amount,
       PERCENT_RANK() OVER (ORDER BY fine_amount DESC) AS percent_rank
FROM Borrowings;

-- SUM() OVER()
SELECT member_id, book_id, borrow_days, fine_amount,
       SUM(fine_amount) OVER (ORDER BY member_id) AS running_total_fine
FROM Borrowings;

-- AVG() OVER()
SELECT member_id, book_id, borrow_days, fine_amount,
       AVG(fine_amount) OVER () AS average_fine
FROM Borrowings;

-- MIN() OVER()
SELECT member_id, book_id, borrow_days, fine_amount,
       MIN(fine_amount) OVER () AS minimum_fine
FROM Borrowings;

-- MAX() OVER()
SELECT member_id, book_id, borrow_days, fine_amount,
       MAX(fine_amount) OVER () AS maximum_fine
FROM Borrowings;

-- LAG()
SELECT member_id, book_id, borrow_days, fine_amount,
       LAG(fine_amount) OVER (ORDER BY fine_amount DESC) AS previous_fine
FROM Borrowings;

-- LEAD()
SELECT member_id, book_id, borrow_days, fine_amount,
       LEAD(fine_amount) OVER (ORDER BY fine_amount DESC) AS next_fine
FROM Borrowings;

-- NTILE()
SELECT member_id, book_id, borrow_days, fine_amount,
       NTILE(4) OVER (ORDER BY fine_amount DESC) AS quartile
FROM Borrowings;

-- CUME_DIST()
SELECT member_id, book_id, borrow_days, fine_amount,
       CUME_DIST() OVER (ORDER BY fine_amount DESC) AS cumulative_distribution
FROM Borrowings;
SHOW databases;
USE onlinebookstore;

LOAD DATA LOCAL INFILE 
'D:/POWERBI/30 Day - SQL Practice Files- SD50/30 Day - SQL Practice Files/Books.csv'
INTO TABLE Books
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE
'D:/POWERBI/30 Day - SQL Practice Files- SD50/30 Day - SQL Practice Files/Customers.csv'
INTO TABLE Customers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE
'D:/POWERBI/30 Day - SQL Practice Files- SD50/30 Day - SQL Practice Files/Orders.csv'
INTO TABLE Orders
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

select * from books;
select * from customers;
select * from orders;

-- Basic Queries


-- 1) Retrieve all books in the "Fiction" genre
select * from books where genre = "Fiction";

-- 2) Find books published after the year 1950
select * from books where Published_Year > 1950;

-- 3) List all customers from the Canada
SELECT * 
FROM Customers where Country = 'Denmark';

-- 4) Show orders placed in November 2023
SELECT *
FROM orders
WHERE MONTHNAME(ORDER_DATE) = 'November'
AND YEAR(ORDER_DATE) = 2023;

SELECT * FROM ORDERS WHERE ORDER_DATE between '2023-11-01' AND '2023-11-30';


-- 5) Retrieve the total stock of books available
SELECT sum(STOCK) AS TOTAL_STOCK FROM BOOKS;

-- 6) Find the details of the most expensive book
SELECT  MAX(PRICE) AS MAXPRICE FROM BOOKS;
SELECT * FROM BOOKS ORDER BY PRICE DESC LIMIT 1;

-- 7) Show all customers who ordered more than 1 quantity of a book
SELECT * FROM ORDERS WHERE QUANTITY>1;

-- 8) Retrieve all orders where the total amount exceeds $20
SELECT * FROM ORDERS WHERE TOTAL_AMOUNT>20;

-- 9) List all genres available in the Books table
SELECT  distinct GENRE FROM BOOKS;

-- 10) Find the book with the lowest stock
SELECT * FROM BOOKS ORDER BY STOCK LIMIT 1;

-- 11) Calculate the total revenue generated from all orders
SELECT SUM(TOTAL_AMOUNT) AS TOTAL_REVENUE FROM ORDERS;


-- Advance Queries

-- 1) Retrieve the total number of books sold for each genre
SELECT GENRE, COUNT(*) AS TOTAL_NUMBERS_GENRE FROM BOOKS GROUP BY GENRE;
SELECT b.genre ,  sum(o.Quantity) from orders as o join books as b where b.Book_ID = o.Book_ID group by b.genre;

-- 2) Find the average price of books in the "Fantasy" genre
select genre , avg(price) from books where genre = "Fantasy";


-- 3) List customers who have placed at least 2 orders
SELECT c.customer_id, c.name
FROM customers c
JOIN orders o
  ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
HAVING COUNT(o.order_id) >= 2 order by customer_id;

SELECT customer_id, name
FROM customers
WHERE customer_id IN (
  SELECT customer_id
  FROM orders
  GROUP BY customer_id
  HAVING COUNT(order_id) >= 2
);

-- 4) Find the most frequently ordered book
select o.book_id,b.title, count(o.order_id) as order_count from orders o
join books b on o.Book_ID = b.Book_ID
group by Book_ID order by order_count desc limit 1;

-- 5) Show the top 3 most expensive books of 'Fantasy' Genre 
select * from books where genre = "Fantasy"order by price desc limit 3;

-- 6) Retrieve the total quantity of books sold by each author
select b.author, count(o.order_id) from orders o join books b on o.book_id = b.book_id group by Author;
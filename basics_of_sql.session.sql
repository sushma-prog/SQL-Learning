USE college;
CREATE TABLE Students(
    studentID INT PRIMARY KEY,
    name VARCHAR(50),
    age INT
);

INSERT INTO students(studentID, name, age)
VALUES(1, "sushma", 20);

SELECT * FROM students;

SELECT * FROM students WHERE (age > 18);    

UPDATE students SET age = 21 WHERE name = "sushma";

DELETE FROM students WHERE name = "sushma";

CREATE TABLE books(
    bookID INT PRIMARY KEY,
    title VARCHAR(50),
    author VARCHAR(50),
    price FLOAT
);

INSERT INTO books(bookID, title, author, price)
VALUES(1, "rich dad poor dad", "robert kiyosaki", 500);

INSERT INTO books(bookID, title, author, price)
VALUES(2, "tian guan ci fu", "mxtx", 6000),
(3, "shamchi aai", "sane guruji", 400);

SELECT * FROM books

SELECT * FROM books WHERE (price > 200);

UPDATE books SET price = 100 WHERE title = "tian guan ci fu";

SELECT * FROM books WHERE (price > 200);

DELETE FROM books WHERE title="tian guan ci fu";

ALTER TABLE books ADD COLUMN (genre VARCHAR(50));

UPDATE books SET genre = "finance" WHERE title = "rich dad poor dad";
UPDATE books SET genre = "historical" WHERE title = "shamchi aai";

/*add contraints*/

ALTER TABLE books MODIFY bookID INT AUTO_INCREMENT;
ALTER TABLE books ADD CONSTRAINT check_price CHECK (price >= 0);

/*create another table for joins*/
CREATE TABLE publishers (
    publisherID INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    country VARCHAR(50)
);

ALTER TABLE books 
ADD CONSTRAINT fk_publisher FOREIGN KEY (publisherID) 
REFERENCES publishers(publisherID) ON DELETE CASCADE;

INSERT INTO publishers (name, country) VALUES
("penguin random house", "USA"),
("bloomsbury", "UK");

INSERT INTO publishers (name, country) VALUES
('Sahitya Akademi', 'India');

UPDATE books SET publisherID = 1 WHERE title = "rich dad poor dad";
UPDATE books SET publisherID = 2 WHERE title = "shamchi aai";

SELECT books.title, books.author, books.price, publishers.name AS publisher, publishers.country
FROM books
INNER JOIN publishers ON books.publisherID = publishers.publisherID;

SELECT books.title, books.author, books.price, books.genre, publishers.name as publisher, publishers.country
FROM books
INNER JOIN publishers ON publishers.publisherID = books.publisherID;

SELECT * FROM publishers;

/*SQL Constraints
Constraints help maintain accuracy and integrity in a database. Let's implement some constraints:

1.1 Add Constraints to books Table
Modify the books table to add constraints:

NOT NULL on title and author
CHECK constraint on price (must be positive)
UNIQUE constraint on title (so duplicate titles aren't allowed)*/

ALTER TABLE books
MODIFY title  VARCHAR(50) NOT NULL UNIQUE,
MODIFY author VARCHAR(50) NOT NULL,
MODIFY price FLOAT CHECK(price > 0);

INSERT INTO books(title, author, price) VALUES 
("agnipankh","dr.A.P.J.Abdul Kalam", 800),
("hamlet", "shakespeare", 100);

INSERT INTO (title, author, price) books VALUES 
("buddha ani tyancha dhamma","Dr.B.R.Ambedkar",1);

/*Exploring Joins
LEFT JOIN (Show all books, even if they don’t have a publisher)
🔹 Purpose: Ensures that even books without a publisher are displayed.*/

SELECT books.title, books.author, books.price, publishers.name AS publisher, publishers.country
FROM books
LEFT JOIN publishers ON publishers.publisherID = books.publisherID;

/*RIGHT JOIN (Show all publishers, even if they don’t have books yet)
🔹 Purpose: Ensures that all publishers are shown, even those who haven’t published a book yet.*/

SELECT books.title, books.author, books.price, publishers.name AS publisher, publishers.country
FROM books
RIGHT JOIN publishers ON publishers.publisherID = books.publisherID;

/*FULL OUTER JOIN (Show all books and publishers, even if they aren’t linked)
MySQL does not support FULL OUTER JOIN, but we can simulate it using UNION:
🔹 Purpose: Combines both LEFT and RIGHT JOIN to ensure we display all books and publishers, even if they aren’t linked.*/

SELECT books.title, books.author, books.price, publishers.name AS publisher, publishers.country
FROM books
LEFT JOIN publishers ON books.publisherID = publishers.publisherID

UNION

SELECT books.title, books.author, books.price, publishers.name AS publisher, publishers.country
FROM books
RIGHT JOIN publishers ON books.publisherID = publishers.publisherID;

SELECT * FROM books;

SELECT COUNT(*) FROM books;
SELECT COUNT(*) AS total_books FROM books;

SELECT AVG(price) AS average_price FROM books;

SELECT MAX(price) AS highest_price, MIN(price) AS lowest_price FROM books;

/* let's group books by publisher and count how many books each publisher has.
🔹 Groups books by publisher and counts how many each has.*/
SELECT publishers.name AS publisher , COUNT(books.bookID) AS total_books
FROM books
INNER JOIN publishers ON publishers.publisherID = books.publisherID
GROUP BY publishers.name;

/*Find Publishers with More Than 1 Book
🔹 Filters to show only publishers with more than 1 book.*/
SELECT publishers.name AS publisher, COUNT(books.bookID)
FROM books
INNER JOIN publishers ON publishers.publisherID = books.publisherID
GROUP BY publishers.name
HAVING COUNT(books.bookID) > 1;

SELECT title, price FROM books
WHERE price > (SELECT AVG(price) FROM books);

SELECT title, price, publisherID FROM books
WHERE price = (SELECT MAX(price) FROM books);

/*LEFT JOIN (Show All Books, Even If They Have No Publisher)*/
SELECT books.title, books.price, books.author, publishers.name as publisher
FROM books
LEFT JOIN publishers ON publishers.publisherID = books.publisherID;

/*RIGHT JOIN (Show All Publishers, Even If They Have No Books)*/
SELECT books.title, books.author, books.price, publishers.name AS publisher
FROM books
RIGHT JOIN publishers ON publishers.publisherID = books.publisherID;

/*FULL OUTER JOIN (Show All Books and Publishers, Even If They Don’t Match)*/
SELECT books.title, books.author, books.price, publishers.name AS publisher
FROM books
LEFT JOIN publishers ON publishers.publisherID = books.publisherID

UNION

SELECT books.title, books.author, books.price, publishers.name AS publisher
FROM books
RIGHT JOIN publishers ON publishers.publisherID = books.publisherID;

/*Indexes help speed up queries. Let’s create some indexes for efficiency.
Create an Index on title for Faster Searches
🔹 Improves performance when searching for books by title.*/
CREATE INDEX idx_title ON books(title);

/*Create an Index on publisherID for Faster Joins
🔹 Speeds up queries that involve publisher information.*/
CREATE INDEX idx_publisherID ON books(publisherID);

/*Get Books with Price Above the Average
🔹 Finds books that cost more than the average book price.*/
SELECT title, price
FROM books
WHERE price > (SELECT AVG(price) FROM books);

/*Get the Most Expensive Book
🔹 Finds the book with the highest price.*/
SELECT title, price
FROM books
WHERE price = (SELECT MAX(price) FROM books);

/*Get Books by a Publisher from a Subquery
🔹 Finds all books published by "Penguin Random House".*/
SELECT title, price
FROM books
WHERE publisherID = (SELECT publisherID FROM publishers WHERE name = "Penguin Random House"); 

/*Create a View for Expensive Books (Price > 500)
🔹 Creates a virtual table for expensive books.*/
CREATE VIEW ExpensiveBooks AS 
SELECT title, author, price
FROM books
WHERE price > 500;

/*Fetch Data from the View
🔹 Uses the view like a normal table.*/
SELECT * FROM ExpensiveBooks;

/*Update a View (If Needed)
🔹 Updates the View to include books with price > 100.*/
CREATE OR REPLACE VIEW ExpensiveBooks AS
SELECT title, author, price
FROM books
WHERE price > 100;

/*Fetch Data from the View*/
SELECT * FROM ExpensiveBooks;

/*Drop a View. Removes the view if not needed.*/
DROP VIEW ExpensiveBooks;

/*Reusable SQL Functions
Create a Stored Procedure to Get Books by Author
This procedure takes an author's name as input and returns all their books.*/
DELIMITER $$
CREATE PROCEDURE GetBooksByAuthor(IN authorName VARCHAR(50))
BEGIN
    SELECT * FROM books WHERE author = authorName;
End$$

DELIMITER;

DELIMITER $$

CREATE PROCEDURE GetBooksByAuthor(IN authorName VARCHAR(50))
BEGIN
    SELECT * FROM books WHERE author = authorName;
END $$

DELIMITER ;




DELIMITER $$

CREATE PROCEDURE GetBooksByAuthor(IN authorName VARCHAR(50))
BEGIN
    SELECT * FROM books WHERE author = authorName;
END $$

DELIMITER ;

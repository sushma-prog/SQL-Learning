-- PROBLEM: Recyclable and Low Fat Products
SELECT product_id FROM Products 
WHERE (low_fats='Y' and recyclable='Y');

-- Problem: Find Customer Referee
SELECT name 
FROM Customer
WHERE referee_id IS NULL OR referee_id != 2;

--problem: Big Countries
SELECT name, population, area FROM World
WHERE area >= 3000000 OR population >= 25000000;

--PROBLEM: Article Views I
SELECT DISTINCT author_id AS id FROM Views
WHERE author_id = viewer_id
ORDER BY id;

--PROBLEM: Invalid Tweets
SELECT tweet_id FROM Tweets
WHERE LENGTH(content) > 15; 

--PROBLEM: Replace Employee ID With The Unique Identifier
SELECT unique_id, name 
FROM Employees
LEFT JOIN EmployeeUNI ON EmployeeUNI.id = Employees.id;

--problem: Product Sales Analysis I
SELECT product_name, year, price FROM Product
RIGHT JOIN Sales ON Product.product_id = Sales.product_id;

--problem:Customer Who Visited but Did Not Make Any Transactions
select customer_id, count(Visits.visit_id) AS count_no_trans FROM Visits
LEFT JOIN Transactions ON Visits.visit_id = Transactions.visit_id
where Transactions.visit_id IS NULL
GROUP BY Visits.customer_id;

--problem: Rising Temperature
SELECT w1.id
FROM Weather w1
JOIN weather w2
ON w1.recordDate = DATE_ADD(w2.recordDate, INTERVAL 1 DAY)
WHERE w1.temperature > w2.temperature;

--problem: Average Time of Process per Machine
SELECT a.machine_id, ROUND(AVG(b.timestamp - a.timestamp), 3) AS processing_time 
FROM Activity a
JOIN Activity b
ON a.machine_id = b.machine_id
AND a.process_id = b.process_id
AND a.Activity_type = "start"
AND b.Activity_type = "end"
GROUP BY a.machine_id;

--problem: Employee Bonus
SELECT name, bonus 
FROM Employee
LEFT JOIN Bonus
ON Employee.empID = Bonus.empID
WHERE bonus < 1000 OR Bonus IS NULL ;

--problem:
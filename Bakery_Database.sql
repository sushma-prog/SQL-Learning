CREATE DATABASE BakeryDB;
USE BakeryDB;

--Customers Table
CREATE TABLE Customers (
    customerID INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    address TEXT
);

--Products Table
ALTER TABLE Products(
    productID INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    price DECIMAL(10,2),
    categoey ENUM("Bread", "Cake", "Pastry", "Cookies"),
    stock INT
);

--Orders Table
CREATE TABLE Orders(
    orderID INT AUTO_INCREMENT PRIMARY KEY,
    customerID INT,
    orderDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    totalAmount DECIMAL(10,2),
    FOREIGN KEY (customerID) REFERENCES Customers(customerID) ON DELETE CASCADE
);

--Order Details Table
CREATE TABLE Order_Details (
    orderDetailID INT AUTO_INCREMENT PRIMARY KEY,
    orderID INT,
    productID INT,
    quantity INT,
    price DECIMAL(10,2),
    CONSTRAINT fk_order FOREIGN KEY (orderID) REFERENCES Orders(orderID) ON DELETE CASCADE,
    CONSTRAINT fk_product FOREIGN KEY (productID) REFERENCES Products(productID)
);

--Add Customers
INSERT INTO Customers (name, email, phone, address) VALUES
("Sushma", "sushma@example.com", "9876543210", "Jalgaon,India"),
("Anjali", "anjali@example.com", "8765432109", "Dharangaon,India");

--Add Products
INSERT INTO Products (name, price, category, stock) VALUES
("Sourdough Bread", 150.00, "Bread", 50),
("Chocolate Cake", 500.00, "Cake", 20),
("Butter Cookies", 250.00, "Cookies", 30);

--Add Orders
INSERT INTO Orders (customerId, totalAmount) VALUES
(1,650.00),
(2,500.00);

--Add Order_Details
INSERT INTO Order_Details (orderID, productID, quantity, price) VALUES
(1, 1, 2, 300.00),
(1, 3, 1, 250.00),
(2, 2, 1, 500.00);

--Get all Customer orders:
SELECT Orders.orderId, Customers.name AS Customer, Orders.orderDate, Orders.totalAmount
FROM orders
JOIN Customers ON Customers.customerID = Orders.customerID;

--Get order details for a specific order(eg.1):
SELECT Orders.orderID, Products.name AS Product, Order_Details.quantity, Order_Details.price
FROM order_details
JOIN Orders ON Orders.orderID = Order_Details.orderID
JOIN Products ON Products.productID = Order_Details.productID
WHERE Orders.orderID = 1;
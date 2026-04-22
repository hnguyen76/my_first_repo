-- This SQL script is intended for MySQL syntax.
-- Create Database Command
CREATE DATABASE online_store;
-- Use Database Command
USE online_store;
-- Create Table Command for customers with domain constraints, data types, and a primary key, 
-- and a timestamp for record creation.   
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE, --email must be unique
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
-- alter table to add a column for contact first name and last name
ALTER TABLE customers
ADD COLUMN contact_first_name VARCHAR(50),
ADD COLUMN contact_last_name VARCHAR(50);

-- Insert some sample data into customers table
CREATE PROCEDURE Insert200Customers()
BEGIN
    DECLARE i INT DEFAULT 1;
    
    WHILE i <= 200 DO
        INSERT INTO customers (first_name, last_name, email)
        VALUES (
            CONCAT('FirstName', i),                     -- generate unique first names by appending the counter to a base name
            CONCAT('LastName', i),                      -- generate unique last names by appending the counter to a base name
            CONCAT('user', i, '_', FLOOR(RAND()*1000), '@example.com') -- generate unique email addresses
        );
        SET i = i + 1; -- increment the counter
    END WHILE; -- end of the procedure
END
-- call the procedure to insert sample data
CALL Insert200Customers();
-- create a product table with product id, name, price and stock qty
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT, -- product id is auto-incremented
    product_name VARCHAR(100) NOT NULL UNIQUE, -- product name must be unique
    price DECIMAL(10,2) NOT NULL CHECK (price > 0), -- price must be greater than 0
    stock_quantity INT NOT NULL DEFAULT 0, -- default stock quantity is 0
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- timestamp for record creation
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- timestamp for record update
);
-- Insert some sample data into products table
-- INSERT INTO products (product_name, price, stock_quantity) VALUES 
-- ('Laptop', 999.99, 10),
-- ('Smartphone', 499.99, 20),
-- ('Headphones', 199.99, 30),
-- ('Monitor', 299.99, 15),
-- ('Keyboard', 49.99, 50);
CREATE PROCEDURE Insert30Products()
BEGIN
    DECLARE i INT DEFAULT 1;
    
    WHILE i <= 30 DO
        INSERT INTO products (product_name, price, stock_quantity)
        VALUES (
            CONCAT('Product_', i + 5),             -- generate unique product names by appending the counter to a base name, starting from 6 to avoid conflict with existing products
            ROUND(50 + (RAND() * 1450), 2),        -- generate unique prices by appending the counter to a base name, starting from 6 to avoid conflict with existing products
            FLOOR(5 + (RAND() * 96))               -- generate unique stock quantities by appending the counter to a base name, starting from 6 to avoid conflict with existing products 
        );
        SET i = i + 1; -- increment the counter
    END WHILE;
END
CALL Insert30Products(); -- call the procedure to insert sample data

-- create an orders table with order number, customer id, order date and total amount
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10,2) DEFAULT 0,-- total amount must be greater than or equal to 0
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) -- foreign key constraint to customers table
);
-- Insert some sample data into orders table
-- INSERT INTO orders (customer_id, order_date, total_amount) VALUES 
-- (1, '2024-01-01', 1499.98),
-- (2, '2024-01-02', 499.99),
-- (3, '2024-01-03', 199.99),
-- (4, '2024-01-04', 299.99),
-- (5, '2024-01-05', 49.99),
-- (6, '2024-01-06', 999.99),
-- (7, '2024-01-07', 499.99),
-- (1, '2024-01-08', 199.99),
-- (2, '2024-01-09', 299.99),
-- (3, '2024-01-10', 49.99),
-- (4, '2024-01-11', 1499.98),
-- (5, '2024-01-12', 499.99),
-- (6, '2024-01-13', 199.99),
-- (7, '2024-01-14', 299.99),
-- (1, '2024-01-15', 49.99),
-- (2, '2024-01-16', 999.99),
-- (3, '2024-01-17', 499.99),
-- (4, '2024-01-18', 199.99),
-- (5, '2024-01-19', 299.99),
-- (6, '2024-01-20', 49.99),
-- (7, '2024-01-21', 1499.98),
-- (2, '2024-01-07', 499.99),
-- (3, '2024-01-08', 199.99),
-- (4, '2024-01-09', 299.99),
-- (5, '2024-01-10', 49.99),
-- (1, '2024-01-11', 1499.98),
-- (2, '2024-01-12', 499.99),
-- (3, '2024-01-13', 199.99),
-- (4, '2024-01-14', 299.99),
-- (5, '2024-01-15', 49.99);
CREATE PROCEDURE Insert500Orders()
BEGIN
    DECLARE i INT DEFAULT 1;
    
    WHILE i <= 500 DO
        INSERT INTO orders (customer_id, order_date, total_amount)
        VALUES (
            FLOOR(1 + (RAND() * 207)),        -- random customer id between 1 and 207 (assuming we have 207 customers)
            DATE_ADD('2024-01-01', INTERVAL FLOOR(RAND() * 730) DAY), -- random order date within the next 2 years
            ROUND(20 + (RAND() * 2000), 2)    -- random total amount between 20.00 and 2020.00
        );
        SET i = i + 1;
    END WHILE;
END
CALL Insert500Orders(); -- call the procedure to insert sample data

-- create orders details table with order number, product id, quantity ordered and price each, and a composite primary key of order number and product id, and foreign key constraints to orders and products tables.
CREATE TABLE orderDetails (
    order_id INT NOT NULL, -- order number must be unique
    product_id INT NOT NULL, -- product id must be unique
    quantityOrdered INT NOT NULL CHECK (quantityOrdered > 0), -- quantity ordered must be greater than 0
    priceEach DECIMAL(10,2) NOT NULL CHECK (priceEach > 0), -- price each must be greater than 0
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- timestamp for record creation
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- timestamp for record update
    PRIMARY KEY (order_id, product_id), -- composite primary key
    FOREIGN KEY (product_id) REFERENCES products(product_id), -- foreign key constraint to products table
    FOREIGN KEY (order_id) REFERENCES orders(order_id) -- foreign key constraint to orders table
);
-- Insert 1000 sample data into orderDetails table
CREATE PROCEDURE InsertSampleOrderDetails()
BEGIN
    DECLARE i INT DEFAULT 1;
    
    WHILE i <= 100 DO
        INSERT INTO orderDetails (order_id, product_id, quantityOrdered, priceEach)
        VALUES (
            FLOOR(1 + (RAND() * 100)),     -- random order id between 1 and 100
            FLOOR(1 + (RAND() * 5)),       -- random product id between 1 and 5
            FLOOR(1 + (RAND() * 10)),      -- random quantity ordered between 1 and 10
            ROUND(10 + (RAND() * 990), 2)  -- random price each between 10 and 1000 with 2 decimal places
        );
        SET i = i + 1;                     -- increment the counter
    END WHILE;
END
CALL InsertSampleOrderDetails(); -- call the procedure to insert sample data

--create table cats with cat id, cat name and cat age
CREATE TABLE cats (
    cat_id INT PRIMARY KEY AUTO_INCREMENT,
    cat_name VARCHAR(50) NOT NULL,
    cat_age INT NOT NULL CHECK (cat_age >= 0)
);

-- RENAME TABLE cats TO categories
-- ALTER TABLE categories
-- ADD COLUMN description TEXT;




-- List all customers and their orders, including customers without orders and orders without customers, sorted by order number.
SELECT
     c.customerName,
     c.customerNumber,
     o.orderNumber,
     o.orderDate,
     p.productName,
     p.buyPrice,
     od.productCode     
FROM
    customers c
INNER JOIN orders o USING (customerNumber)
INNER JOIN orderdetails od USING (orderNumber)
INNER JOIN products p USING (productCode);
-- List all customers and their orders, including customers without orders and orders without customers, sorted by order number.
SELECT
     c.customerName,
     c.customerNumber,
     orderNumber,
     o.status
FROM
    customers c
    LEFT JOIN orders o ON c.customerNumber = o.customerNumber
WHERE 
    o.status IS NULL;
-- List all customers and their sales representatives, including customers without sales representatives and sales representatives without customers, sorted by customer name.
SELECT customerNumber, salesRepEmployeeNumber
FROM employees
RIGHT JOIN customers ON employeeNumber = salesRepEmployeeNumber
ORDER BY customerName;
-- List all customers and their payments, including customers without payments and payments without customers, sorted by customer name.
SELECT * 
FROM customers e 
CROSS JOIN payments p;
-- List all employees and their managers, including the first and last names of both employees and managers, sorted by employee last name.
SELECT 
    e1.`firstName`,
    e1.`lastName`,
    e2.`firstName` AS managerFirstName,
    e2.`lastName` AS managerLastName
FROM
    employees e1
    JOIN employees e2 ON e1.reportsTo = e2.employeeNumber;
-- List all customers who are in the same city as another customer, along with the names of those customers, sorted by city.
SELECT 
    c1.city, 
    c1.customerName, 
    c2.customerName

FROM 
customers c1
INNER JOIN customers c2 ON c1.city = c2.city
    AND c1.customername > c2.customerName
ORDER BY c1.city;
-- List all employees and customers, including their first and last names, sorted alphabetically by first name.
SELECT firstName, lastName
FROM employees 
UNION 
SELECT contactFirstName, contactLastName
FROM customers;
-- List all customers and their orders, including customers without orders and orders without customers, sorted by order number.
SELECT *
FROM customers c
LEFT JOIN orders o ON c.customerNumber = o.customerNumber
UNION 
SELECT *
FROM customers c
RIGHT JOIN orders o ON c.customerNumber = o.customerNumber
GROUP BY orderNumber;
-- Each customer Name with an alias, along with the name of the employees
-- responsible for that customer order , the employee should be a full name, sorted by customer name alphabetically.

SELECT 
    c.customerName,
    CONCAT(e.firstName, ' ', e.lastName) AS employeeFullName
FROM customers c
LEFT JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber
ORDER BY c.customerName;

-- which products are the most popular with our customers
-- product, toal qty ordered, sales generated total, 'product Name" total # ordered, Total Sale
-- sorted hightest total sale at the top
SELECT
    p.productName AS `Product Name`,
    format(SUM(od.quantityOrdered), 0) AS Total_Order,
    format(SUM(od.quantityOrdered * od.priceEach), 2) AS Total_Sale 
FROM products p
JOIN orderdetails od USING (productCode)
GROUP BY p.productName
ORDER BY `Total_Sale` DESC;

--list each product lines, total num of products sold in each line
--descriptive alias ordered by the second column in descending order
-- Join productlines to products, then products to orderdetails for accurate aggregation
SELECT 
    pl.productLine AS 'Product Line',
    count(od.productCode) AS TotalProducts
FROM productlines pl
LEFT JOIN products p USING(productLine)
LEFT JOIN orderdetails od USING(productCode)
GROUP BY pl.productLine
ORDER BY 2 DESC;
-- List the total payments received each month, along with the month and year, sorted by year and month in ascending order.
SELECT  
    MONTHNAME(paymentDate) AS PaymentMonth,
    YEAR(paymentDate) AS PaymentYear,
    FORMAT(TRUNCATE(SUM(amount), 2), 2) AS TotalPayments
FROM payments
GROUP BY PaymentYear, PaymentMonth
ORDER BY PaymentYear, PaymentMonth ASC;
use classicmodels;
SELECT
	productName AS Name,
    productLine AS ProductLine,
    productScale As Scale,
    productVendor As productVendor
FROM
	products
WHERE
	productLine IN('Classic Cars', 'Vintage Cars')
ORDER BY
	productLine DESC,
    NAME ASC;
---- Write a query for the classicmodels db, that shows ALL customers, 
--the number of orders for each customer and the average order amount. Sort by order count ASC

use classicmodels;
SELECT 
    c.customerName AS CustomerName,
    Count(o.orderNumber) AS "OrderCount",
    AVG(od.quantityOrdered * od.priceEach) AS AverageOrderAmount
FROM customers c
LEFT JOIN orders o USING(customerNumber)
LEFT JOIN orderdetails od USING(orderNumber)
GROUP BY c.customerName
ORDER BY "OrderCount" ASC;
use hr;
SELECT employee_id, first_name, last_name, department_id
FROM employees
WHERE department_id IN (SELECT 
        department_id 
        FROM departments 
        WHERE location_id = 1700)
ORDER BY first_name, last_name;

--find MAX salary for each department, and list the department name, location and max salary
SELECT first_name, last_name, MAX(salary) --won't work because of the aggregate function
FROM employees;

SELECT first_name, last_name, salary
FROM employees
ORDER BY salary DESC
LIMIT 1;

SELECT *
FROM employees
WHERE salary = (SELECT MAX(salary) FROM employees);

--who has above avg salary

SELECT *
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

SELECT *
FROM employees
WHERE salary > 10000;

SELECT department_id, department_name
FROM departments d
WHERE NOT EXISTS (SELECT * 
FROM employees 
WHERE salary > 10000 AND department_id = d.department_id);

SELECT department_id, AVG(salary)
FROM employees
GROUP BY department_id;

SELECT ROUND(AVG(avg_salary),2) AS Overall_Avg_Salary
FROM 
    (SELECT AVG(salary) AS avg_salary
     FROM employees
     GROUP BY department_id) AS avg_by_dept;

--top 5 products by total sales, use classicmodels shipped in 2003
SELECT
    productCode,
    SUM(quantityOrdered * priceEach) AS sales
FROM 
    orderdetails
INNER JOIN orders USING(orderNumber)
WHERE 
    YEAR(shippedDate) = 2003
GROUP BY productCode
ORDER BY sales DESC
LIMIT 5;

SELECT productName, sales
FROM 
    (SELECT
        productCode,
        SUM(quantityOrdered * priceEach) AS sales
    FROM 
        orderdetails
    INNER JOIN orders USING(orderNumber)
    WHERE 
        YEAR(shippedDate) = 2003
    GROUP BY productCode
    ORDER BY sales DESC
    LIMIT 5) AS top_products
INNER JOIN products USING(productCode);


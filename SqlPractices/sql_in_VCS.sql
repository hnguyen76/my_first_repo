-- -- SELECT 
-- --     CONCAT(`firstName`,`lastName`,'@example.com') AS email
-- -- FROM employees;

-- SELECT 
--     TRIM('  Hello World!   ') AS trimmed_string, 
--     LTRIM('  Hello World!   ') AS ltrimmed_string,
--     RTRIM('  Hello World!   ') AS rtrimmed_string;

-- SELECT
--     YEAR(shippedDate) AS year,
--     COUNT(*) AS total_orders
-- FROM orders
-- WHERE 
--     shippedDate IS NOT NULL 
--     AND 
--     status = 'Shipped'
-- GROUP BY 
--     year WITH ROLLUP
-- ORDER BY 
--     year desc;

-- SELECT
--     DAY(orderDate) AS order_date,
--     COUNT(*) AS total_orders
-- FROM orders
-- WHERE YEAR(orderDate) = 2004
-- GROUP BY 
--     DAY(orderDate)
-- ORDER BY
--     DAY(orderDate) DESC;

-- SELECT
--     customerNumber,
--     sum(amount) AS TotalSpent,
--     round(AVG(amount), 2) AS AvgPayment,
--     Count(*) AS NumPayments
-- FROM 
--     payments
-- GROUP BY 
--     customerNumber
-- Having 
--     NumPayments >= 5 
--     AND 
--     TotalSpent > 100000
-- ORDER BY 
--     TotalSpent DESC;


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

--Name, Product Line, 
--and all classic 

use banking;
SELECT 
    p.NAME AS `Product`,
    pt.Name AS `Product Type`
FROM product p
inner join product_type pt USING (PRODUCT_TYPE_CD); 

--each branch, list the branch name and the city
--plus the last name and tittle of each ee who working in that branch
SELECT 
    b.NAME AS "Branch Name",
    b.CITY AS City,
    e.LAST_NAME AS 'Employee Last Name',
    e.TITLE AS "Employee Title" 
FROM branch b
INNER JOIN employee e ON e.ASSIGNED_BRANCH_ID = b.BRANCH_ID;

--unique ee tittle
SELECT DISTINCT TITLE
FROM employee;

SELECT 
    e1.`LAST_NAME` AS EmployeeLastName,
    e1.`TITLE` AS EmployeeTitle,
    e2.`LAST_NAME` AS ManagerLastName,
    e2.`TITLE` AS ManagerTitle
FROM employee e1
LEFT JOIN employee e2 ON e1.SUPERIOR_EMP_ID = e2.EMP_ID;

--each account show the name of the account product, available balance and the customer last name 

SELECT 
    p.NAME AS `Product Name`,
    a.AVAIL_BALANCE as `Available Balance`,
    i.LAST_NAME AS `Customer Last Name`
FROM account a
INNER JOIN customer c USING (CUST_ID)
LEFT JOIN product p USING (PRODUCT_CD)
LEFT JOIN individual i USING (CUST_ID);


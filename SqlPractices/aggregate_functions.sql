-- DateTime Functions

-- CURRENT_DATE() - selects the current date
SELECT CURRENT_DATE();
SELECT CURDATE();

-- Gets Timestamp
SELECT CURRENT_TIMESTAMP();
-- Gets current time (TIME of day) hhmmss
SELECT CURRENT_TIME(3);

-- MONTH() selects month from a date
SELECT
	MONTH(orderDate)
FROM
	orders;

-- YEAR()
SELECT
	YEAR(orderDate)
FROM
	orders;

-- DAY()
SELECT
	DAY(orderDate)
FROM
	orders;
    
    
SELECT
	MONTH(paymentDate),
    SUM(amount) AS totalPayments
FROM
	payments
GROUP BY 
	MONTH(paymentDate)
ORDER BY
	totalPayments DESC;
    
-- DATEFORMAT() allows you to change the format of your dates
SELECT DATE_FORMAT(CURDATE(), '%W, %M %e %Y');


SELECT 
    p.paymentDate AS `Actual Date`,
    DATE_FORMAT(p.paymentDate, '%W %e %M %Y') AS `Formatted Date`
FROM
    payments p;

-- DATEDIFF() calculated the difference between dates in number of days
SELECT
	AVG(DATEDIFF(shippedDate, orderDate)) AS averageDaysToShip
FROM
 orders;


SELECT 
    CURRENT_DATE(),
    orderDate,
    DATEDIFF(CURRENT_DATE(), orderDate) AS 'Orders received Days',
    DATEDIFF(CURRENT_DATE(), shippedDate) AS 'Order Shipping Days'
FROM
    classicmodels.orders;

-- If statement runs a conditional and provides one of two outputs
-- conditional an expression that evaluates either to true or false
SELECT IF( 100 > 200, 'yes', 'no');

SELECT
	IF(amount > 10000, 1, 0) AS TheyGotMoney,
    amount
FROM
	payments;Dylan Comeau  [11:14 AM]
use classicmodels;

-- Describe command to tell you the data types
DESCRIBE orders;

-- Replace() string values in view
SELECT 
    customerName,
    country,
	REPLACE(country, 'USA', 'US') AS updatedCountry
FROM customers
WHERE country = 'USA';

-- Concat() to add together strings or data
SELECT
	CONCAT(contactFirstName, " ", contactLastName) AS FullName,
    city,
    country
FROM
	customers;

-- Upper() - upper case all string values;
SELECT
	*, 
    UPPER(city)
FROM
	customers;

-- LOWER() - lowercase all string values;
SELECT
	*,
	LOWER(city)
FROM
	customers;

-- Count() - counts records
SELECT
	productLine,
	COUNT(*)
FROM
	products
GROUP BY
	productLine;
    
-- SUM() - adds together numerical values
SELECT
	SUM(quantityOrdered) AS TotalItemsOrdered
FROM
	orderdetails;

SELECT
	SUM(amount) AS TotalPaymentAmount
FROM
	payments;
    
SELECT
	SUM(quantityOrdered * priceEach) as orderTotal
FROM
	orderdetails
WHERE
	orderNumber = '10100';
    
-- MIN MAX - gives min and max values, must be number or date type
SELECT
	MAX(amount),
    MIN(amount)
FROM
	payments;
    
SELECT
	MIN(VacationHours),
    MAX(VacationHours)
FROM
	employees;
    
SELECT
	MIN(orderDate),
    MAX(orderDate)
FROM
	orders;

-- Avg calculates the mean of records or groups of records
SELECT 
    officeCode, AVG(VacationHours)
FROM
    employees
GROUP BY officeCode;

SELECT
	AVG(creditLimit) AS AVG_LiMIT
FROM
	customers;

SELECT
	AVG(buyPrice)
FROM
	products;
    
-- MOD()
SELECT MOD(12, 0.18);


SELECT
	MOD(quantityOrdered, 2),
    quantityOrdered
FROM
	orderDetails;
    
-- Round rounds to the nearest number based on the second argument
-- second arg positive nums rounds the right side of the decimal place
-- negative nums rounds the left side of the decimal
SELECT ROUND(1323.55, -3);

-- CEILING/CEIL - always rounds up
SELECT CEILING(1323.55);
-- FLOOR - always rounds down
SELECT FLOOR(1323.55);

-- Truncate just cuts off the number at a set number of decimal



SELECT
	customerNumber,
    SUM(amount) AS TotalSpent,
    TRUNCATE(AVG(amount), 2) as AvgPayment
FROM
	payments
WHERE
	paymentDate > '2004-01-01'
GROUP BY
	customerNumber
ORDER BY
	TotalSpent DESC;

SELECT ROUND(123.55, 1);


-- DateTime Functions

-- CURRENT_DATE() - selects the current date
SELECT CURRENT_DATE();
SELECT CURDATE();

-- Gets Timestamp
SELECT CURRENT_TIMESTAMP();
-- Gets current time (TIME of day) hhmmss
SELECT CURRENT_TIME(3);

-- MONTH() selects month from a date
SELECT
	MONTH(orderDate)
FROM
	orders;

-- YEAR()
SELECT
	YEAR(orderDate)
FROM
	orders;

-- DAY()
SELECT
	DAY(orderDate)
FROM
	orders;
    
    
SELECT
	MONTH(paymentDate),
    SUM(amount) AS totalPayments
FROM
	payments
GROUP BY 
	MONTH(paymentDate)
ORDER BY
	totalPayments DESC;
    
-- DATEFORMAT() allows you to change the format of your dates
SELECT DATE_FORMAT(CURDATE(), '%W, %M %e %Y');


SELECT 
    p.paymentDate AS `Actual Date`,
    DATE_FORMAT(p.paymentDate, '%W %e %M %Y') AS `Formatted Date`
FROM
    payments p;

-- DATEDIFF() calculated the difference between dates in number of days
SELECT
	AVG(DATEDIFF(shippedDate, orderDate)) AS averageDaysToShip
FROM
 orders;


SELECT 
    CURRENT_DATE(),
    orderDate,
    DATEDIFF(CURRENT_DATE(), orderDate) AS 'Orders received Days',
    DATEDIFF(CURRENT_DATE(), shippedDate) AS 'Order Shipping Days'
FROM
    classicmodels.orders;

-- If statement runs a conditional and provides one of two outputs
-- conditional an expression that evaluates either to true or false
SELECT IF( 100 > 200, 'yes', 'no');

SELECT
	IF(amount > 10000, 1, 0) AS TheyGotMoney,
    amount
FROM
	payments;

SELECT 
    SUM(IF(status = 'Shipped', 1, 0)) AS Shipped,
    SUM(IF(status = 'Cancelled', 1, 0)) AS Cancelled
FROM
    classicmodels.orders;


-- IFNULL() - checks to see if either arg is null,
-- if first arg is NOT NULl, it will be returned ELSE is will return the second ARG
SELECT 
    customerNumber,
    addressLine1,
    addressLine2,
    IFNULL(addressLine2, addressLine1) AS CustomerAddress
FROM
    customers;

-- MD5() used to hash strings using 128-bit MD% standar4d
SELECT MD5('MypasswordFor20Dollar$'); 

-- TYPE CASTING - changing a piece of data into a specific datatype
-- CAST()
SELECT CAST(13 AS CHAR);
-- 1. Janet asks us whether the number of products a customer orders (quantityOrdered) is odd orr even
-- we also want the total of qty of items PER ORDER
SELECT
	orderNumber,
    SUM(quantityOrdered) AS Qty,
    IF(
		MOD(SUM(quantityOrdered), 2) = 1, -- our condition
        'Odd', 'Even' -- out true or false resoponses
	) AS evenOfOdd
FROM
	orderDetails
GROUP BY
	orderNumber
ORDER BY
	orderNumber;
    
-- 2. Janet says Im bad at math, fix this number 1.5555, remove all but 1 decimal place, NO ROUNDING
SELECT TRUNCATE(1.5555555, 1);

-- 3. Janet asks us to find avg order value or all orders AND ROUND() after,
SELECT
	productCode,
    ROUND(AVG(quantityOrdered * priceEach), 2) AS AvgOrderValue
FROM
	orderDetails
GROUP BY
	productCode;


-- 5. Janet asks, can we get a list of orders which has the most days left before its required
SELECT
	orderNumber,
    DATEDIFF(requiredDate, shippedDate) as daysLeftTillRequired
FROM
	orders
ORDER BY
	daysLeftTillRequired DESC;
    

-- 6. Janet says, I cant read a clock, I have trouble reading in most formats, reformat the dates in the orders table;
-- orderdate 'yyyy-m-dd'
-- requireddate 'weekdat, dayofmonth, MMM, year'
-- shippedDate 'full weekday, dayodMonth with suffix, full month name, year'
SELECT
	orderNumber,
    DATE_FORMAT(orderDate, '%Y-%m-%d') AS OrderDate,
    DATE_FORMAT(requiredDate, '%a %D %b %Y') AS RequiredDate,
    DATE_FORMAT(shippedDate, '%W %D %M %Y') AS ShippedDate
FROM
	orders;

-- 7. create work emails by add together first and last name, add @example.com to the right of that
SELECT
	CONCAT(firstName, lastName, '@example.com') AS email,
    email
FROM 
	employees;
	
-- SELECT 
--     RPAD(CONCAT(firstName, lastName),
--             CHAR_LENGTH('@example.com'),
--             '@example.com') AS email
-- FROM
-- 	employees;
--     
    
    
-- 8. Remove white space from DB name
SELECT TRIM('        MySQLDB            ');
SELECT RTRIM('        MySQLDB            '); -- Trim Right
SELECT LTRIM('        MySQLDB            ');-- Trim Left
    
    
-- 9. Janet please pull a report that says how many total orders we have per year
-- I actually mean orders shipped

SELECT
	YEAR(shippedDate),
    COUNT(*) AS orderQty
FROM
	orders
GROUP BY
	YEAR(shippedDate)
ORDER BY
	YEAR(shippedDate) ASC;
-- Null is always considered the smalled value
    
    
    
-- 10. For the year 2004, can you calculate the number of orders per day of the month
SELECT
	DAY(orderDate),
    COUNT(*) AS Qty
FROM
	orders
WHERE
	YEAR(orderDate) = 2004
GROUP BY
	DAY(orderDate)
ORDER BY
	DAY(orderDate);
    
    
    
    
    
SELECT
	*
FROM
	orders
WHERE
	shippedDate IS NULL;
    

SELECT
	*
FROM
	employees
WHERE
	reportsTo IS NULL;
    
    
SELECT 
    customerNumber,
    customerName,
    country,
    state,
    IF(state IS NULL, 'N/A', state) AS state
FROM
    classicmodels.customers;
    
SELECT
	*
FROM
	customers
WHERE
	country NOT IN ('USA', 'France');
    
    
    
    
SELECT
	*
FROM
	customers
WHERE
	country='USA'
    or
    country='France';

-- Simple case statement, 1 case value (column)
SELECT
	orderLineNumber,
    CASE orderLineNumber
		WHEN 1 THEN 'NYC Warehouse'
        WHEN 2 THEN 'NJ Warehouse'
        WHEN 3 THEN 'CA Warehouse'
        WHEN 4 THEN 'PA Warehouse'
        ELSE 'ML Warehouse'
	END AS ProductStatus
FROM
	orderdetails;


-- Searched Case Statement
SELECT 
    productName,
    buyPrice,
    CASE
        WHEN buyPrice > 9 AND buyPrice <= 50 THEN 'LOW PRICE'
        WHEN buyPrice >= 50 AND buyPrice <= 100 THEN 'Medium Price'
        WHEN buyPrice > 100 AND buyPrice <= 200 THEN 'high Price'
        ELSE 'Out of our range'
    END AS priceStatus
FROM
    products
ORDER BY buyPrice DESC;


    

SELECT 
    customerName, state, country
FROM
    customers
ORDER BY (CASE
    WHEN state IS NULL THEN country
    ELSE state
END);


SELECT
    orderNumber,
    FORMAT(SUM(quantityOrdered), 0) AS totalItems,
    IF(MOD(SUM(quantityOrdered), 2)=0, 'Even', 'Odd') AS totalQuantity,
    FORMAT(SUM(quantityOrdered * priceEach), 2) AS totalAmount
FROM orderdetails
GROUP BY orderNumber
ORDER BY totalAmount DESC;

select
TRUNCATE(1.555,1) as truncated_value;
SELECT  
    productCode, 
    FORMAT(ROUND(avg(quantityOrdered * priceEach), 2), 2) AS RoundAvgTotalAmount
FROM orderdetails
GROUP BY productCode;

SELECT
    orderNumber,
    DATEDIFF(requiredDate, shippedDate) AS daysBetween
FROM orders
ORDER BY daysBetween DESC;

SELECT
    orderNumber,
    DATE_FORMAT(orderDate, '%Y-%m-%d') AS orderdate,
    DATE_FORMAT(requiredDate, '%a-%D-%b-%Y') AS requireddate,
    DATE_FORMAT(shippedDate, '%W-%D-%M-%Y') AS shippeddate
FROM orders;
 SELECT
    DAY(orderDate) AS order_date,
    COUNT(*) AS total_orders
FROM orders
WHERE YEAR(orderDate) = 2004
GROUP BY 
    DAY(orderDate)
ORDER BY
    DAY(orderDate) DESC;

SELECT
    orderLineNumber,
    CASE `orderLineNumber`
        WHEN 1 THEN 'NYC warehouse'
        WHEN 2 THEN 'NJ warehouse'
        WHEN 3 THEN 'CT warehouse'
        WHEN 4 THEN 'PA warehouse'
        ELSE 'ML warehouses'
    END AS ProductStatus 
FROM
    orderdetails;

SELECT productName, buyPrice,
    CASE 
        WHEN buyPrice < 50 THEN 'Low Price'
        WHEN buyPrice >= 50 AND buyPrice < 100 THEN 'Medium Price'
        ELSE 'High Price'
    END AS PriceCategory
FROM products;

SELECT
    customerName, state, country
FROM customers
ORDER BY
    CASE 
        WHEN state is NULL THEN country 
        ELSE state
    END;         

SELECT DISTINCT CITY
FROM STATION
WHERE CITY regexp '^[^aeiou].*[^aeiou]$';-- ^ means starts with, [^aeiou] means not aeiou, . means any character, * means 0 or more of the previous character, $ means ends with

SELECT Name
FROM STUDENTS
WHERE marks > 75
order BY Right(Name,3) ASC, ID ASC; -- Right() function takes the rightmost characters of a string, in this case 3 characters, and orders by those characters first, then orders by ID if there are ties in the rightmost 3 characters
SELECT *
FROM offices;

SELECT lastName, firstName 
FROM employees
WHERE officeCode IN (1,2,3,2200,3001);

SELECT  lastName, firstName, officeCode
FROM employees
WHERE officeCode  IN
    (SELECT officeCode FROM offices WHERE country = 'USA');

 -- find the customer who pays highest amount.
SELECT 
    c.customerNumber,
    c.contactFirstName,
    checkNumber,
    amount AS HighestAmount
FROM
    payments p
        INNER JOIN
    customers c USING(customerNumber)
WHERE
    amount = (SELECT 
            MAX(amount)
        FROM
            payments);
-- subquery with WHERE
SELECT 
    c.customerNumber, 
    c.contactFirstName, 
    p.checkNumber, 
    p.amount AS HighestAmount
FROM 
    payments p
INNER JOIN 
    customers c ON p.customerNumber = c.customerNumber
WHERE 
    p.amount = (SELECT MAX(amount) FROM payments);
    
-- SUBquery with HAVING    
SELECT 
    firstName, AVG(VacationHours) AS AverageVacationHours
FROM
    employees
GROUP BY employeeNumber
HAVING AVG(VacationHours) > (SELECT AVG(VacationHours)
							 FROM employees);
                             
-- code not working bellow ... fixing next
SELECT 
    pp.customerNumber,
    pp.checkNumber,
    pp.amount,
    c.customerName,
    AVG(pp.amount)
FROM
    payments pp
INNER JOIN customers c USING (customerNumber)
GROUP BY pp.customerNumber
HAVING AVG(pp.amount) > (SELECT 
        AVG(p.amount) AS avgamount
    FROM
        payments p);

SELECT 
    c.customerName,
    c.customerNumber, 
    AVG(pp.amount) AS CustomerAvgAmount,
    (SELECT AVG(amount) FROM payments) AS GlobalAvgAmount
FROM 
    payments pp
INNER JOIN 
    customers c USING (customerNumber)
GROUP BY 
    c.customerNumber, c.customerName
HAVING 
    AVG(pp.amount) > (SELECT AVG(amount) FROM payments)
ORDER BY 
    CustomerAvgAmount DESC;

-- finds the maximum, minimum, and average number of items in the sale orders:
SELECT 
    MAX(items), MIN(items), (AVG(items))
FROM
    (SELECT 
        orderNumber, COUNT(orderNumber) AS items
    FROM
        orderdetails
    GROUP BY orderNumber) AS lineitems;

-- Here is a query that returns the top 10 percent of revenue-generating orders.
SELECT 
    orderNumber, SUM(quantityOrdered * priceEach) GR
FROM
    orderdetails
GROUP BY orderNumber
HAVING GR >= (SELECT 
        0.9 * MAX(GR)
    FROM
        (SELECT 
            orderNumber, SUM(quantityOrdered * priceEach) GR
        FROM
            orderdetails
        GROUP BY orderNumber) AS gross);

-- eturns products with buyingprices > the average price in their product line.
SELECT productname, buyprice
	FROM products p1
	WHERE buyprice > (
		SELECT AVG(buyprice)
		FROM products
		WHERE productline = p1.productline);


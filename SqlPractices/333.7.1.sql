-- Active: 1776193943026@@127.0.0.1@3306@banking
se classicmodels;
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

-- CREATE VIEW customer_payment AS
USE CLASSICMODELS;
CREATE VIEW customer_payment AS
SELECT 	c.customerName,	concat(contactfirstName, " ", contactLastName) AS ContactRep,	p.amount,	p.paymentDate
FROM	customers c
INNER JOIN payments p
ON c.customerNumber = p.customerNumber
ORDER BY p.paymentDate;

use classicmodels;
SELECT *
FROM customer_payment;





use classicmodels;
SELECT pl.productLine, COUNT(p.productCode) AS NumberOfProducts
FROM productlines pl
LEFT JOIN products p USING(productLine)
GROUP BY pl.productLine;
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

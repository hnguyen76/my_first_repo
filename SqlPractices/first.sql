-- use command to choose a database
/* use classicmodels
single line comments are

command in SQL are known as clauses SQL 
Capitalization doesn't technically matter, but you should always
General ALL purpose queries (fetching data):

	start with SELECT
    FROM what tables
    END with a semi colon;
    
    SELECT something (columns, attribute)
    FROM tables;
    */

    
    SELECT
		orderNumber, OrderDate
    FROM orders
    WHERE orderDate LIKE '2003-04-%' 
		OR orderDate LIKE '2003-01-%';
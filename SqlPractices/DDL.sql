--our manager wants to see how much revenue each customer has generated, along with how many payments they’ve made.
-- Highest total paid should be first

-- Classicmodels DB

-- Displays:

-- Customer name
-- Total amount paid
-- Number of payments
Use classicmodels;
SELECT
    c.customerName,
    SUM(p.amount) AS RevenueGenerated,
    COUNT(*) AS NumberOfPayments
FROM customers c
    LEFT JOIN payments p USING (customerNumber)
GROUP BY
    c.customerNumber
ORDER BY RevenueGenerated DESC;


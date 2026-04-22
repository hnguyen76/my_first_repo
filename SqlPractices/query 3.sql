SELECT status AS Status
FROM orders
GROUP BY status
ORDER BY status;
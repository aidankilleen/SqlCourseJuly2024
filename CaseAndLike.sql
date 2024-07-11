-- Pattern matching using LIKE

SELECT * FROM Customers
WHERE CompanyName LIKE '%arket';

SELECT * FROM Customers
WHERE ContactTitle LIKE 'ssistant';

-- LIKE finds by pattern
-- % matches any characters
-- _ matches any single character
SELECT * FROM Customers
WHERE ContactName LIKE '_o%';

SELECT * FROM Customers;


-- CASE
-- use a CASE Statement in a WHERE clause
SELECT 
	o.OrderID, 
	os.Subtotal, 
	CASE
		WHEN Subtotal > 10000 THEN 'Big'
		WHEN Subtotal > 1000 THEN 'Medium'
		ELSE 'Small'
	END AS Classification
FROM Orders o INNER JOIN [Order Subtotals] os
ON o.OrderID = os.OrderID
WHERE CASE
		WHEN Subtotal > 10000 THEN 'Big'
		WHEN Subtotal > 1000 THEN 'Medium'
		ELSE 'Small'
	END  = 'Big'
ORDER BY Subtotal DESC;


-- AGGREGATE on a CASE
SELECT 
	CASE
		WHEN Subtotal > 10000 THEN 'Big'
		WHEN Subtotal > 1000 THEN 'Medium'
		ELSE 'Small'
	END AS Classification, 
	SUM(os.Subtotal) AS Total
FROM Orders o INNER JOIN [Order Subtotals] os
ON o.OrderID = os.OrderID
GROUP BY 
	CASE
		WHEN Subtotal > 10000 THEN 'Big'
		WHEN Subtotal > 1000 THEN 'Medium'
		ELSE 'Small'
	END;


SELECT * FROM Customers;


SELECT * INTO #akCustomers FROM Customers;

SELECT * FROM Customers;

DELETE FROM #akCustomers WHERE CustomerID = 'ALFKI' OR CustomerID = 'ANTON';

-- or I could use IN

DELETE FROM #akCustomers WHERE CustomerID IN ('ALFKI', 'ANTON');


-- Find the customers that are in Customers but are missing from #akCustomers;
SELECT c.CustomerID, c.CompanyName, akc.CustomerID FROM
Customers c LEFT JOIN #akCustomers akc
ON c.CustomerID = akc.CustomerID
WHERE akc.CustomerID IS NULL;

INSERT INTO Customers
(CustomerID, CompanyName)
VALUES('AK101', 'Professional Training');

INSERT INTO #akCustomers
(CustomerID, CompanyName)
VALUES('AK901', 'Other Training');

-- Find the customers that are in #akCustomers but are missing from Customers
SELECT c.CustomerID, akc.CompanyName, akc.CustomerID FROM
Customers c RIGHT JOIN #akCustomers akc
ON C.CustomerID = akc.CustomerID
WHERE c.CustomerID IS NULL;

-- just use a LEFT join and reverse the tables 
SELECT akc.CustomerID FROM
#akCustomers akc LEFT JOIN Customers c
ON c.CustomerID = akc.CustomerID
WHERE c.CustomerID IS NULL;

SELECT * FROM #akCustomers;

UPDATE asCustomers
SET CompanyName = 'Changed Company'
WHERE CustomerID = 'ISLAT';

-- Find the company that has a changed CompanyName

SELECT * FROM asCustomers;

DELETE FROM asCustomers WHERE CustomerID = 'SAVEA';

SELECT COUNT(*) FROM asCustomers;

-- find customers in Customers and not in asCustomers;
SELECT c.CustomerID, c.CompanyName, ac.CustomerID FROM
Customers c LEFT JOIN asCustomers ac
ON c.CustomerID = ac.CustomerID
WHERE ac.CustomerID IS NULL;


-- can you find the one one that has changed?
SELECT c.CustomerID, c.CompanyName, akc.CompanyName 
FROM Customers c INNER JOIN #akCustomers akc
ON c.CustomerID = akc.CustomerID
WHERE c.CompanyName <> akc.CompanyName;

SELECT * FROM #akCustomers WHERE CustomerID = 'AROUT';

SELECT * FROM Customers WHERE CustomerID = 'AROUT';

UPDATE Customers
SET CompanyName = 'Also Changed'
WHERE CustomerID = 'AROUT';


-- find a duplicate?

SELECT * FROM #akCustomers WHERE CompanyName = 'Professional Training';
UPDATE #akCustomers SET CompanyName = 'Professional Training' WHERE CustomerID = 'ISLAT';

SELECT CompanyName, COUNT(*)
FROM Customers
GROUP BY CompanyName
HAVING COUNT(*) > 1;

SELECT * FROM #akCustomers WHERE CompanyName = 'Professional Training';


SELECT * FROM Customers WHERE CompanyName IN ('Also Changed', 'Professional Training');

-- Wouldn't it be cool if you could put these two together
-- find the list of customers
-- who have duplicate names in the Customers table:
-- use IN with a SubQuery
SELECT * FROM Customers 
WHERE CompanyName IN (
	SELECT CompanyName FROM Customers 
	GROUP BY CompanyName 
	HAVING COUNT(*) > 1
);

SELECT * FROM Customers WHERE Country = 'Mexico';
SELECT * FROM Orders WHERE CustomerID IN ('ANTON', 'CENTC', 'PERIC', 'TORTU');

SELECT * 
FROM Orders 
WHERE CustomerID IN (
	SELECT CustomerID 
	FROM Customers 
	WHERE Country = 'Mexico'
);

-- list the last order for each of my 10 biggest customers

-- 10 biggest customers
SELECT TOP 10 CustomerID, SUM(Subtotal)
FROM Orders o INNER JOIN [Order Subtotals] os
ON o.OrderID = os.OrderID
GROUP BY CustomerID
ORDER BY SUM(Subtotal) DESC;

-- last order ID for each customer
SELECT CustomerID, MAX(OrderID) 
FROM Orders
WHERE CustomerID IN ('ANTON', 'AROUT')
GROUP BY CustomerID

-- put these together
SELECT CustomerID, MAX(OrderID) 
FROM Orders
WHERE CustomerID IN (
	SELECT TOP 10 CustomerID
	FROM Orders o INNER JOIN [Order Subtotals] os
	ON o.OrderID = os.OrderID
	GROUP BY CustomerID
	ORDER BY SUM(Subtotal) DESC
) 
GROUP BY CustomerID;


-- get all the order details for this subset of orders
SELECT * FROM Orders /* list a subset of orders */
	WHERE OrderID IN (
		SELECT MAX(OrderID) /* find the latest orderID for a subset of customers */
		FROM Orders
		WHERE CustomerID IN (
			SELECT TOP 10 CustomerID	/* get the top 10 customers */
			FROM Orders o INNER JOIN [Order Subtotals] os
			ON o.OrderID = os.OrderID
			GROUP BY CustomerID
			ORDER BY SUM(Subtotal) DESC
		) 
	GROUP BY CustomerID	
);




;




























DELETE FROM Customers WHERE LEFT(CustomerID, 2) = 'AK';
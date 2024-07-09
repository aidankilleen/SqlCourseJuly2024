-- DQL - Data Query Langauge
-- the SELECT statement

SELECT * FROM Customers;

SELECT CustomerID, CompanyName FROM Customers;

SELECT CompanyName, City, PostalCode, Country FROM Suppliers;

-- This is a comment

-- SQL is not case senstive BUT it is recommended (strongly) that you adhere to some rules
select * from customers;

-- All SQL keywords will be written in ALL CAPS
-- preserve the case from table names and field names
SELECT * FROM Customers;

/*
this is a multi-line comment
*/


-- semi colons at the end of a line are optional
-- it is recommended to use them 
SELECT * FROM Customers

SELECT * FROM Suppliers


SELECT * FROM Orders;

-- We can select a subset by using WHERE
-- different parts of SQL are often referred to as clauses
-- strings (text data) are delimited with single quotes.
SELECT * FROM Customers WHERE Country = 'UK';

-- whitespace is ignored
SELECT * FROM Customers 
WHERE 
	Country = 'UK' 
	OR Country = 'Ireland';

-- be consistent in using whitespace, newlines and tabs

SELECT * FROM Customers
WHERE Country = 'USA'
AND Region = 'WA';


SELECT * FROM Customers
WHERE Country = 'USA'
AND Region = 'WA' OR Region = 'CA';


SELECT * FROM Customers
WHERE Country = 'USA' OR Country = 'UK';


SELECT * FROM Orders
WHERE OrderDate = '1996-07-04';		-- YYYY-MM-DD 

SELECT * FROM Orders WHERE OrderDate < '1996-08-01';

SELECT * FROM Orders 
WHERE 
	OrderDate > '1996-08-01' 
	AND OrderDate < '1996-08-10';

-- BETWEEN does work on SQL Server
SELECT * FROM Orders
WHERE OrderDate BETWEEN '1996-08-01' AND '1996-08-10';

-- DESC - sort in descending order

-- sort by text, number or date
SELECT * FROM Customers 
WHERE Country = 'UK'
ORDER BY ContactName DESC;

SELECT * FROM Orders 
WHERE OrderDate < '1996-08-10'
ORDER BY Freight DESC;

SELECT * 
FROM Orders 
WHERE OrderDate < '1996-08-10'
ORDER BY OrderDate DESC;

-- aggregate operations

SELECT * FROM Orders;

SELECT COUNT(*) FROM Orders;

SELECT COUNT(*) FROM Customers;

SELECT * FROM Customers;

-- If you have an aggregate function all fields in the SELECT must
-- either be aggregated or part of the GROUP BY clause
SELECT Country, COUNT(CustomerID) 
FROM Customers
GROUP BY Country;

-- COUNT, MAX, MIN, SUM, AVG

SELECT * FROM Orders ORDER BY Freight DESC;

SELECT MAX(Freight) FROM Orders;

SELECT MIN(Freight) FROM Orders;

-- Use an alias to give a name to a column
-- it is valid to have spaces in table names, field names and other database elements
-- use [] to use things with spaces in their names.
SELECT ShipCountry AS [The Country], MAX(Freight) AS MaxFreight, MIN(Freight) AS MinFreight 
FROM Orders
GROUP BY ShipCountry;

SELECT * FROM [Order Details];

SELECT * FROM Orders WHERE OrderID = 10248;

SELECT * FROM [Order Details] WHERE OrderID = 10248;

SELECT * FROM Customers WHERE CustomerID = 'VINET';

SELECT * FROM Employees WHERE EmployeeID = 5;

SELECT Customers.CustomerID, OrderID, CompanyName, OrderDate
FROM Customers INNER JOIN Orders 
ON Customers.CustomerID = Orders.CustomerID
WHERE Customers.CustomerID = 'VINET'
ORDER BY OrderDate DESC;


SELECT * FROM [Order Details]
WHERE OrderID = 10248;

SELECT * FROM Products WHERE ProductID = 11 OR ProductID = 42 OR ProductID = 72;


SELECT OrderId, [Order Details].UnitPrice, Quantity, ProductName 
FROM [Order Details] INNER JOIN Products 
ON [Order Details].ProductID = Products.ProductID
WHERE OrderID = 10248
ORDER BY ProductName;


-- We can do calculations
SELECT OrderId, [Order Details].UnitPrice * Quantity AS LineValue, ProductName 
FROM [Order Details] INNER JOIN Products 
ON [Order Details].ProductID = Products.ProductID
WHERE OrderID = 10248
ORDER BY ProductName;

-- We can do an aggregate
SELECT OrderId, SUM([Order Details].UnitPrice * Quantity) AS OrderValue 
FROM [Order Details] INNER JOIN Products 
ON [Order Details].ProductID = Products.ProductID
GROUP BY OrderId;


-- get sum of all orders for a customer
-- use WHERE to filter the records that are used for an aggregate
-- use HAVING to filter the results of the aggregate.
SELECT 
	Orders.OrderID, CustomerID, OrderDate,
	SUM([Order Details].UnitPrice * [Order Details].Quantity) AS OrderValue
FROM Orders INNER JOIN [Order Details]
ON Orders.OrderID = [Order Details].OrderID
WHERE CustomerID = 'VINET'
GROUP BY Orders.OrderID, CustomerID, OrderDate
--HAVING SUM([Order Details].UnitPrice * [Order Details].Quantity) > 250
ORDER BY OrderValue DESC;


-- get the total for each customer

-- use an alias for the tables in the join to
--	shorten the query
--	might make it easier to follow
SELECT 
	CustomerID, 
	SUM(od.UnitPrice * od.Quantity) AS OrderValue
FROM Orders o INNER JOIN [Order Details] od
ON o.OrderID = od.OrderID
GROUP BY CustomerID
ORDER BY OrderValue DESC;


-- more complex
-- build up complex queries one join at a time

SELECT 
	o.OrderID, o.CustomerID, o.EmployeeID, o.OrderDate,
	c.CompanyName as CustomerCompanyName, 
	e.FirstName + ' ' + e.LastName AS [Employee Name], 
	od.ProductID, od.Quantity * od.UnitPrice AS LineValue,
	p.ProductName, p.SupplierID, p.CategoryID, 
	ct.CategoryName, 
	s.CompanyName as SupplierCompanyName, s.ContactName as SupplierContactName
FROM Orders o INNER JOIN Customers c
ON o.CustomerID = c.CustomerID
INNER JOIN Employees e
ON o.EmployeeID = e.EmployeeID
INNER JOIN [Order Details] od
ON o.OrderID = od.OrderID
INNER JOIN Products p
ON od.ProductID = p.ProductID
INNER JOIN Categories ct
ON p.CategoryID = ct.CategoryID
INNER JOIN Suppliers s
ON p.SupplierID = s.SupplierID;


SELECT COUNT(*) FROM [Order Details];


-- agregate a complex query
-- note you don't need to SELECT fields that are used elsewhere in the query
SELECT 
	ct.CategoryName, SUM(od.UnitPrice * od.Quantity) AS Total
FROM Orders o INNER JOIN Customers c
ON o.CustomerID = c.CustomerID
INNER JOIN Employees e
ON o.EmployeeID = e.EmployeeID
INNER JOIN [Order Details] od
ON o.OrderID = od.OrderID
INNER JOIN Products p
ON od.ProductID = p.ProductID
INNER JOIN Categories ct
ON p.CategoryID = ct.CategoryID
INNER JOIN Suppliers s
ON p.SupplierID = s.SupplierID
GROUP BY ct.CategoryName
ORDER BY Total DESC;



SELECT 
	p.ProductID, p.ProductName, SUM((od.UnitPrice * od.Quantity) * (1 - Discount)) as Total
FROM Orders o INNER JOIN Customers c
ON o.CustomerID = c.CustomerID
INNER JOIN Employees e
ON o.EmployeeID = e.EmployeeID
INNER JOIN [Order Details] od
ON o.OrderID = od.OrderID
INNER JOIN Products p
ON od.ProductID = p.ProductID
INNER JOIN Categories ct
ON p.CategoryID = ct.CategoryID
INNER JOIN Suppliers s
ON p.SupplierID = s.SupplierID
GROUP BY p.ProductID, p.ProductName
ORDER BY Total DESC;

SELECT * FROM Products WHERE ProductID = 38;

SELECT * FROM [Order Details] WHERE ProductID = 38;

SELECT SUM(Quantity) FROM [Order Details] WHERE ProductID = 38;

SELECT 263.50 * 623;

-- NB - seems like there is a discrepancy

-- main query says we sold 149 K of product 38

-- we sold 623 units,  the unit price is 263.50  = 164K  
-- NB: we need to get to the bottom of why there is a difference.



-- DISTINCT
SELECT Country FROM Customers; -- list all the countries including repeats

SELECT DISTINCT Country FROM Customers;

SELECT DISTINCT Country FROM Suppliers;


-- TOP
-- returns n rows from the query
-- the sort order of the query is what determines the "top"
SELECT TOP 5 * FROM Customers;

SELECT TOP 5 * FROM Customers
ORDER BY CustomerID DESC;


SELECT TOP 1
	p.ProductID, p.ProductName, SUM(od.UnitPrice * od.Quantity) as Total
FROM Orders o INNER JOIN Customers c
ON o.CustomerID = c.CustomerID
INNER JOIN Employees e
ON o.EmployeeID = e.EmployeeID
INNER JOIN [Order Details] od
ON o.OrderID = od.OrderID
INNER JOIN Products p
ON od.ProductID = p.ProductID
INNER JOIN Categories ct
ON p.CategoryID = ct.CategoryID
INNER JOIN Suppliers s
ON p.SupplierID = s.SupplierID
GROUP BY p.ProductID, p.ProductName
ORDER BY Total DESC;


-- who is the top employee?
-- 
SELECT TOP 1
	e.EmployeeID, e.FirstName + ' ' + e.LastName AS [Employee Name],
	SUM(od.Quantity * od.UnitPrice) as Total
FROM Orders o INNER JOIN Customers c
ON o.CustomerID = c.CustomerID
INNER JOIN Employees e
ON o.EmployeeID = e.EmployeeID
INNER JOIN [Order Details] od
ON o.OrderID = od.OrderID
INNER JOIN Products p
ON od.ProductID = p.ProductID
INNER JOIN Categories ct
ON p.CategoryID = ct.CategoryID
INNER JOIN Suppliers s
ON p.SupplierID = s.SupplierID
GROUP BY e.EmployeeID, e.FirstName + ' ' + e.LastName
ORDER BY Total DESC;



-- Subquery
-- example of a subquery
-- this subquery calculates the sub total for an order
SELECT OrderID, SubTotal FROM (
	SELECT OrderID, SUM(UnitPrice * Quantity) as SubTotal 
	FROM [Order Details]
	GROUP BY OrderID
) AS SubTotalQuery
WHERE OrderID = 10248;

-- this query queries information about the order
-- and uses an inner join to the sub query to get the subtotal
SELECT Orders.OrderID, OrderDate, SubTotal 
FROM Orders INNER JOIN (
	SELECT OrderID, SUM(UnitPrice * Quantity) as SubTotal 
	FROM [Order Details]
	GROUP BY OrderID
) as SubTotalQuery
ON Orders.OrderID = SubTotalQuery.OrderID;



SELECT * FROM akOrderSubtotalView;

SELECT Orders.OrderID, Orders.OrderDate, akOrderSubtotalView.SubTotal
FROM Orders INNER JOIN akOrderSubtotalView
ON Orders.OrderID = akOrderSubtotalView.OrderID;



SELECT * FROM akAllOrderDetails
WHERE OrderID = 10249;

SELECT 
	o.OrderID, o.CustomerID, o.EmployeeID, o.OrderDate,
	c.CompanyName as CustomerCompanyName, 
	e.FirstName + ' ' + e.LastName AS [Employee Name], 
	od.ProductID, od.Quantity * od.UnitPrice AS LineValue,
	p.ProductName, p.SupplierID, p.CategoryID, 
	ct.CategoryName, 
	s.CompanyName as SupplierCompanyName, s.ContactName as SupplierContactName
FROM Orders o INNER JOIN Customers c
ON o.CustomerID = c.CustomerID
INNER JOIN Employees e
ON o.EmployeeID = e.EmployeeID
INNER JOIN [Order Details] od
ON o.OrderID = od.OrderID
INNER JOIN Products p
ON od.ProductID = p.ProductID
INNER JOIN Categories ct
ON p.CategoryID = ct.CategoryID
INNER JOIN Suppliers s
ON p.SupplierID = s.SupplierID
WHERE OrderID + 10249;




SELECT 
	o.OrderID, o.OrderDate, o.CustomerID,
	os.Subtotal, 
	akos.Subtotal
FROM Orders o INNER JOIN [Order Subtotals] os
ON o.OrderID = os.OrderID
INNER JOIN akOrderSubtotalView akos
ON o.OrderID = akos.OrderID;


SELECT * FROM [Order Details] WHERE OrderID = 10250;

SELECT * FROM [Order Subtotals];


SELECT 
	OrderID, Discount, 
	(UnitPrice * Quantity) AS LineValue,
	(UnitPrice * Quantity) * (1 - Discount) AS LineValueWithDiscount
FROM [Order Details];
















































































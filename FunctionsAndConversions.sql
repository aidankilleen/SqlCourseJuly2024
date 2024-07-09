-- SQL Server Functions


-- String functions
SELECT * FROM Employees;

SELECT FirstName, LastName FROM Employees;

SELECT FirstName + ' ' + LastName AS EmployeeName FROM Employees;

SELECT CONCAT(FirstName, ' ', LastName) AS EmployeeName FROM Employees;

SELECT LEFT(FirstName, 1), FirstName FROM Employees;

SELECT LEFT(FirstName, 3), FirstName FROM Employees;

SELECT RIGHT(FirstName, 1), FirstName FROM Employees;

SELECT * FROM Customers;

-- use these functions in the select part or in the WHERE part
SELECT TOP 5 TRIM(CompanyName), CompanyName FROM Customers;

SELECT * FROM Customers
WHERE CompanyName = 'Alfreds Futterkiste';

SELECT * FROM Customers
WHERE TRIM(CompanyName) = 'Alfreds Futterkiste';

SELECT * FROM Customers
WHERE LEFT(TRIM(CompanyName), 7) = 'Alfreds';

SELECT * FROM Customers;

SELECT * FROM Customers WHERE 
	CHARINDEX('market', CompanyName) <> 0
	OR CHARINDEX('market', Address) <> 0;

SELECT * FROM Customers;
SELECT SUBSTRING(Phone, 1, 4) FROM Customers;

SELECT LOWER(ContactName), UPPER(ContactName) FROM Customers;

SELECT CURRENT_USER;

SELECT RAND();

-- Date & Time Functions
SELECT GETDATE();

SELECT OrderDate FROM Orders;
-- extract pieces of the date
SELECT OrderDate, YEAR(OrderDate), MONTH(OrderDate), DAY(OrderDate) FROM Orders;

SELECT * FROM Orders
WHERE YEAR(OrderDate) = 1996
AND MONTH(OrderDate) = 7;

SELECT * FROM Orders 
WHERE OrderDate BETWEEN '1996-07-01' AND '1996-07-30';



SELECT OrderDate, ShippedDate, 
DATEDIFF(dd, OrderDate, ShippedDate) AS OrderLength 
FROM Orders;

SELECT DATEDIFF(hh, '2024-07-09 08:00:00', GETDATE())

SELECT DATEDIFF(mi, '2024-07-09 08:00:00', GETDATE())


SELECT OrderDate, ShippedDate, 
DATEDIFF(dd, OrderDate, ShippedDate) AS OrderLength 
FROM Orders
WHERE DATEDIFF(dd, OrderDate, ShippedDate) > 30;



SELECT DATEFROMPARTS(2024, 7, 9);

-- find orders +/- 10 days from a specified date
SELECT 
	OrderDate, 
	DATETIMEFROMPARTS(1997,7,9,10, 20, 0, 0),
	DATEDIFF(d, DATETIMEFROMPARTS(1997,7,9,10, 20, 0, 0), OrderDate)  
FROM Orders
WHERE DATEDIFF(d, DATETIMEFROMPARTS(1997,7,9,10, 20, 0, 0), OrderDate) < 10 
AND DATEDIFF(d, DATETIMEFROMPARTS(1997,7,9,10, 20, 0, 0), OrderDate) > -10;


SELECT EOMONTH(GETDATE());


SELECT GETDATE(), DATEADD(dd, 10, GETDATE());

SELECT * FROM Orders
WHERE OrderDate BETWEEN '1996-08-01' AND DATEADD(dd, 5, '1996-08-01')


SELECT DATEPART(wk, GETDATE());

SELECT * FROM Orders 
WHERE DATEPART(wk, OrderDate) = 45
AND YEAR(OrderDate) = 1997;

SELECT DATEPART(dw, GETDATE());

-- all orders made on Saturdays
SELECT * FROM Orders 
WHERE DATEPART(dw, OrderDate) = 6;


-- convert string containing american date into a DATETIME 
SELECT CONVERT(DATETIME, '12/31/2023', 101);

-- invalid date (not American format) - causes conversion error
SELECT CONVERT(DATETIME, '31/12/2023', 101);

-- 103 
SELECT CONVERT(DATETIME, '31/12/2023', 103);


SELECT CONVERT(DATETIME, '31 Dec 2023', 106);


SELECT NEWID();


SELECT CAST(4.32123 AS INT)

SELECT CAST('4.321' AS INT);


SELECT CAST(Freight AS INT), * FROM Orders WHERE CAST(Freight AS INT) = 25;






















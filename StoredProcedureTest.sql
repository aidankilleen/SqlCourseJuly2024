
EXEC [Sales by Year] '1997-01-01', '1997-12-31';


EXEC [Ten Most Expensive Products];


EXEC akGetCustomerSummary 'SAVEA';


-- CustomerID, ProductID, Quantity
EXEC akCreateOrder 'AK101', 6, 10;

SELECT TOP 1 * FROM Orders
ORDER BY OrderID DESC;

SELECT * FROM [Order Details]
WHERE OrderID = 11103;

SELECT * FROM Products WHERE ProductID = 5;
-- result is
-- create the Order record
-- create the Order details record
-- Automatically assign the OrderDate and RequiredDate
-- hard coded Employee (5)











SELECT * FROM Customers WHERE CustomerID = 'AK101';

SELECT * FROM Orders;

INSERT INTO Orders
(CustomerID, EmployeeID, OrderDate, RequiredDate)
VALUES
('AK101', 5, GETDATE(), DATEADD(dd, 5, GETDATE()));

-- what was the newly create ID?
DECLARE @OrderID INT;
SELECT @OrderID = SCOPE_IDENTITY();
PRINT @OrderID;

INSERT INTO [Order Details]
(OrderID, ProductID, UnitPrice, Quantity)
VALUES(11089, 4, 22.0, 10);


SELECT SCOPE_IDENTITY();

SELECT TOP 1 * FROM [Order Details] ORDER BY OrderID DESC;
SELECT * FROM Products;



-- Customer Details.sql
DECLARE @CustomerID NCHAR(5) = 'SAVEA';

DECLARE @Value NVARCHAR(255);
DECLARE @SomeValue NVARCHAR(255);

-- assign a value to a variable using SET
--SET @CustomerID = 'SAVEA';

DECLARE @Result MONEY;

SET @Result = (SELECT SUM(os.Subtotal) as Total
	FROM Orders o 
	INNER JOIN [Order Subtotals] os
	ON o.OrderID = os.OrderID
	WHERE CustomerID = @CustomerID
	GROUP BY o.CustomerID
);

DECLARE @OrderCount INT;

SET @OrderCount = (SELECT COUNT(*) FROM Orders WHERE CustomerID = @CustomerID);

PRINT '@Result = ' + CONVERT(NVARCHAR, @Result);

SELECT 
	@CustomerID AS CustomerID, 
	c.CompanyName,
	@Result AS TotalOrderValue, 
	@OrderCount AS OrderCount
FROM Customers c
WHERE CustomerID = @CustomerID;







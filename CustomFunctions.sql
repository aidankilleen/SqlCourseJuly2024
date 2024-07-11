-- Custom Functions.sql


SELECT GETDATE();


SELECT dbo.akAdd(99, 20);


SELECT * FROM [Order Details];

SELECT 
	od.ProductID, od.Quantity, 
	dbo.akAdd(od.ProductID, od.Quantity) AS Answer
FROM [Order Details] od
WHERE dbo.akAdd(od.ProductID, od.Quantity) > 100;


SELECT dbo.akGetOrderItemCount(10248);

SELECT 
	dbo.akGetOrderItemCount(OrderID) AS ItemCount, * 
FROM 
	Orders
WHERE dbo.akGetOrderItemCount(OrderID) >= 5
ORDER BY ItemCount DESC;


SELECT * FROM [Order Details] WHERE OrderID = 10248;

SELECT dbo.akGetOrderItemQuantity(10248);

SELECT 
	dbo.akGetOrderItemQuantity(OrderID) AS ItemTotal, * 
FROM 
	Orders 
WHERE dbo.akGetOrderItemQuantity(OrderID) > 280
ORDER BY ItemTotal DESC;


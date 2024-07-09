CREATE VIEW [dbo].[akOrderSubtotalView]
AS
SELECT        OrderID, SUM(UnitPrice * Quantity) AS SubTotal
FROM            dbo.[Order Details]
GROUP BY OrderID
GO

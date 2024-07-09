CREATE VIEW [dbo].[akAllOrderDetails]
AS
SELECT        o.OrderID, o.CustomerID, o.EmployeeID, o.OrderDate, c.CompanyName AS CustomerCompanyName, e.FirstName + ' ' + e.LastName AS [Employee Name], od.ProductID, od.Quantity * od.UnitPrice AS LineValue, p.ProductName, 
                         p.SupplierID, p.CategoryID, ct.CategoryName, s.CompanyName AS SupplierCompanyName, s.ContactName AS SupplierContactName
FROM            dbo.Orders AS o INNER JOIN
                         dbo.Customers AS c ON o.CustomerID = c.CustomerID INNER JOIN
                         dbo.Employees AS e ON o.EmployeeID = e.EmployeeID INNER JOIN
                         dbo.[Order Details] AS od ON o.OrderID = od.OrderID INNER JOIN
                         dbo.Products AS p ON od.ProductID = p.ProductID INNER JOIN
                         dbo.Categories AS ct ON p.CategoryID = ct.CategoryID INNER JOIN
                         dbo.Suppliers AS s ON p.SupplierID = s.SupplierID
GO


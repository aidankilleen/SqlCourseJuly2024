/****** Object:  StoredProcedure [dbo].[akGetCustomerSummary]    Script Date: 11/07/2024 08:03:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      Aidan
-- Create Date: 10/7/2024
-- Description: GetCustomerSummary
-- =============================================
ALTER PROCEDURE [dbo].[akGetCustomerSummary]
(
    -- Add the parameters for the stored procedure here
    @CustomerID NCHAR(5) = 'SAVEA'
)
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON

	DECLARE @OrderCount INT;
	SET @OrderCount = (
		SELECT 
			COUNT(*) 
		FROM Orders 
		WHERE CustomerID = @CustomerID
	);

	DECLARE @TotalOrderValue MONEY;

	SET @TotalOrderValue = (
		SELECT 
			SUM(SubTotal) 
		FROM Orders o INNER JOIN [Order Subtotals] os
		ON o.OrderID = os.OrderID
		WHERE o.CustomerID = @CustomerID
	);

	-- when was the last order for this customer
	DECLARE @LastOrderDate DATETIME;
	DECLARE @LastOrderID INT;

	SELECT TOP 1
		@LastOrderDate = OrderDate, 
		@LastOrderID = OrderID
	FROM Orders 
	WHERE CustomerID = @CustomerID
	ORDER BY OrderID DESC

    -- resultset from the procedure
    SELECT 
		@CustomerID AS CustomerID, 
		CompanyName, 
		@OrderCount AS OrderCount, 
		@TotalOrderValue AS TotalOrderValue, 
		@LastOrderID AS LastOrderID,
		@LastOrderDate AS LastOrderDate
	FROM Customers c
	WHERE c.CustomerID = @CustomerID;
END

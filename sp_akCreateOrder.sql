/****** Object:  StoredProcedure [dbo].[akCreateOrder]    Script Date: 11/07/2024 08:03:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[akCreateOrder]
(
	-- Parameters with default values
    @CustomerID NCHAR(5) = 'AK101',
	@ProductID INT = 10,
	@Quantity INT
)
AS
BEGIN

    SET NOCOUNT ON

	-- check if the customer exists
	DECLARE @Count INT = (
		SELECT 
			COUNT(*) 
		FROM Customers 
		WHERE CustomerID = @CustomerID
	);

	IF @Count = 0
		BEGIN
			PRINT 'Customer not found';
			RETURN;
		END

	-- figure out the price for this product
	DECLARE @UnitPrice MONEY;
	SELECT 
		@UnitPrice = UnitPrice 
	FROM Products
	WHERE ProductID = @ProductID;

	IF @UnitPrice IS NULL
		BEGIN
			PRINT 'Product Not Found!';
			RETURN;
		END
	-- create an order record
	INSERT INTO Orders
		(CustomerID, EmployeeID, OrderDate, RequiredDate)
	VALUES
		(@CustomerID, 5, GETDATE(), DATEADD(dd, 5, GETDATE()));
	
	-- get the OrderID
	DECLARE @OrderID INT;
	SET @OrderID = SCOPE_IDENTITY();
	PRINT @OrderID;

	-- create the order details record
	INSERT INTO [Order Details]
		(OrderID, ProductID, UnitPrice, Quantity)
	VALUES
		(@OrderID, @ProductID, @UnitPrice, @Quantity);
	
    PRINT 'Finished';
END

/****** Object:  UserDefinedFunction [dbo].[akGetOrderItemQuantity]    Script Date: 11/07/2024 08:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER FUNCTION [dbo].[akGetOrderItemQuantity]
(
	@OrderID INT
)
RETURNS INT
AS
BEGIN
	DECLARE @Total INT;

	SELECT 
		@Total = SUM(Quantity) 
	FROM [Order Details]
	WHERE OrderID = @OrderID;

    RETURN @Total;
END

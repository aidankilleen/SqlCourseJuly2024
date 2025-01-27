/****** Object:  UserDefinedFunction [dbo].[akGetOrderItemCount]    Script Date: 11/07/2024 08:02:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER FUNCTION [dbo].[akGetOrderItemCount]
(
    @OrderID INT
)
RETURNS INT
AS
BEGIN
	DECLARE @Count INT;

	SELECT @Count = COUNT(*) FROM [Order Details]
	WHERE OrderID = @OrderID;

    RETURN @Count;
END

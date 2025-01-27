/****** Object:  StoredProcedure [dbo].[akExceptionInvestigation]    Script Date: 11/07/2024 08:03:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[akExceptionInvestigation]
(
	@CustomerID NCHAR(5)
)
AS
BEGIN
    SET NOCOUNT ON

	-- check if the Customer exists

	BEGIN TRY
		INSERT INTO Orders
			(CustomerID, OrderDate, RequiredDate)
		VALUES
			(@CustomerID, GETDATE(), DATEADD(dd, 10, GETDATE()))

		PRINT 'Order created';

	END TRY
	
	BEGIN CATCH
		
		PRINT 'Something went wrong'

		-- what actually went wrong???
		PRINT ERROR_NUMBER();
		PRINT ERROR_MESSAGE();
		PRINT ERROR_SEVERITY();
		PRINT ERROR_STATE();
		PRINT ERROR_LINE();

	END CATCH
	
	PRINT 'Finished';
    
END

/****** Object:  StoredProcedure [dbo].[akGenerateTestData]    Script Date: 11/07/2024 08:03:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[akGenerateTestData]
(
	@NumberOfRecords INT = 1
)
AS
BEGIN
    SET NOCOUNT ON

	-- create a list of product names (temporary table)
	CREATE TABLE #Products (Name VARCHAR(50));
	INSERT INTO #Products
		(Name)
		VALUES('pen'), 
			  ('pencil'), 
			  ('paint'), 
			  ('crayon'), 
			  ('paper'), 
			  ('card');

	DECLARE @Product VARCHAR(50);
	DECLARE @Colour VARCHAR(50);
	DECLARE @MemberID INT;

	-- create a list of colours (temporary table)
	CREATE TABLE #Colours (Name VARCHAR(50));
	INSERT INTO #Colours (Name)
		VALUES
			('red'), 
			('green'), 
			('blue'), 
			('orange');
	

	DECLARE @I INT = 0;

	WHILE @I < @NumberOfRecords
	BEGIN
		SET @I = @I + 1;
		SET @Product = (
			SELECT TOP 1 Name 
			FROM 
				#Products 
			ORDER BY NEWID()
		);
		SET @Colour = (
			SELECT TOP 1 Name 
			FROM #Colours 
			ORDER BY NEWID()
		);

		SET @MemberID = (
			SELECT 
				TOP 1 MemberID 
			FROM 
				akMembers
			ORDER BY NEWID()	
		);

		INSERT INTO akRecords
			(MemberID, ProductName, Colour, Quantity)
			VALUES(@MemberID, @Product, @Colour, FLOOR(RAND() * 100));

	END
END

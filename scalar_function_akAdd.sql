/****** Object:  UserDefinedFunction [dbo].[akAdd]    Script Date: 11/07/2024 08:01:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER FUNCTION [dbo].[akAdd]
(
    @a INT, 
	@b INT
)
RETURNS INT
AS
BEGIN
    RETURN @a + @b;
END

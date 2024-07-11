-- PIVOT Table

SELECT COUNT(*) FROM akRecords;

SELECT TOP 20 * FROM akRecords;

SELECT *
FROM 
	(SELECT ProductName, Colour, Quantity FROM akRecords) AS SourceTable
PIVOT(
	SUM(Quantity) FOR Colour IN ([red],[green],[blue],[orange])

) AS PivotTable;




SELECT DISTINCT Colour FROM akRecords;

SELECT ProductName, SUM(Quantity) AS Total
FROM akRecords
WHERE ProductName = 'pencil'
AND Colour = 'red'
GROUP BY ProductName;

SELECT * from akRecords;

-- Pivot table with 
-- Members on the rows
-- ProductName as the columns

SELECT m.Name, r.ProductName, r.Quantity 
FROM 
	akRecords r INNER JOIN akMembers m
ON r.MemberID = m.MemberID;
	;

SELECT DISTINCT ProductName FROM akRecords;

SELECT *
FROM 
	(
		SELECT m.Name, r.ProductName, r.Quantity 
		FROM 
			akRecords r INNER JOIN akMembers m
		ON r.MemberID = m.MemberID
	) AS SourceTable
PIVOT(
	SUM(Quantity) FOR ProductName IN ([pencil],[paint],[card],[Pen],[crayon],[paper])

) AS PivotTable;

SELECT * FROM akMembers;

SELECT MemberID, SUM(Quantity) AS Total
FROM akRecords
WHERE ProductName = 'pencil'
AND MemberID = 1006
GROUP BY MemberID;
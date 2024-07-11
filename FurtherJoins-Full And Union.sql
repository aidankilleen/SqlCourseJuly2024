SELECT * FROM akMarketingTable;


SELECT * FROM akSupportTable;

-- FULL JOIN

-- All of the customers who either had a Support Query or a Marketing Query

SELECT CASE
			WHEN m.CustomerID IS NULL THEN s.CustomerID
			ELSE m.CustomerID
		END AS CustomerID
FROM akMarketingTable m FULL JOIN akSupportTable s
ON m.CustomerID = s.CustomerID;


SELECT DISTINCT CASE
			WHEN m.CustomerID IS NULL THEN s.CustomerID
			ELSE m.CustomerID
		END AS CustomerID
FROM akMarketingTable m FULL JOIN akSupportTable s
ON m.CustomerID = s.CustomerID;


-- UNION
-- joins the results of two different queries
-- returns unique records only (same effect as using DISTINCT)

SELECT CustomerID, Comment FROM akMarketingTable
UNION
SELECT CustomerID, Comment FROM akSupportTable;

-- Union can sometimes be useful to combine data from two separate tables.
SELECT Country FROM Customers
UNION
SELECT Country FROM Suppliers;




















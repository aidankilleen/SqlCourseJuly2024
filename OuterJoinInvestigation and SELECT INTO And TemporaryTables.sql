-- investigating joins


SELECT COUNT(*) FROM Customers;

SELECT * FROM Orders;

-- order count by customer
SELECT 
c.CustomerID, c.CompanyName, COUNT(o.OrderID) as OrderCount
FROM Customers c INNER JOIN Orders o
ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.CompanyName;

-- there is a customer with no orders - this customer is missing from the second query

-- and inner join must have an entry on both sides of the join

-- an outer join will list all items from one side and include items from the other side
-- IF they exist
SELECT 
c.CustomerID, c.CompanyName, COUNT(o.OrderID) as OrderCount
FROM Customers c LEFT OUTER JOIN Orders o
ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.CompanyName;


SELECT * FROM Customers WHERE CustomerID = 'PARIS';
SELECT * FROM Orders WHERE CustomerID = 'PARIS';

-- customers that have 0 orders:
SELECT 
c.CustomerID, c.CompanyName, COUNT(o.OrderID) as OrderCount
FROM Customers c LEFT OUTER JOIN Orders o
ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.CompanyName
HAVING COUNT(o.OrderID) = 0;

-- any right hand join can be rewritten as a left 
-- so I always use LEFT
-- you can leave out the OUTER keyword
SELECT 
c.CustomerID, c.CompanyName, COUNT(o.OrderID) as OrderCount
FROM Orders o RIGHT OUTER JOIN Customers c
ON o.CustomerID = c.CustomerID
GROUP BY c.CustomerID, c.CompanyName;


-- SELECT INTO

SELECT * INTO akCustomers FROM Customers WHERE Country = 'USA';


SELECT * FROM akCustomers;

-- delete the table
DROP TABLE akCustomers;

SELECT * FROM asCustomers;

-- Temporary Table
-- if you put a # in front of the table name then a temporary table will be created
-- temporary table is only visible to the current user
-- temporary table will be automatically dropped when the user logs out or the session ends.
SELECT * INTO #akCustomers FROM Customers WHERE Country = 'USA';


SELECT * FROM #akCustomers;


















-- 
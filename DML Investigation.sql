-- DML
-- Data Manipulation Language


INSERT INTO Customers 
	(CustomerID, CompanyName, Address, City, Country)
VALUES
	('AK101', 'Professional Training', 'Cork Airport Business Park', 'Cork', 'Ireland');

SELECT * FROM Customers WHERE LEFT(CustomerID, 2) = 'AK';

INSERT INTO Customers 
	(CustomerID, CompanyName, Address, City, Country)
VALUES
	('AK101', 'Professional Training', 'Cork Airport Business Park', 'Cork', 'Ireland');

SELECT * FROM Orders;

INSERT INTO Orders
	(CustomerID, EmployeeID, OrderDate, RequiredDate)
VALUES
	('AK101', 5, GETDATE(), DATEADD(dd, 10, GETDATE()));

SELECT * FROM Orders WHERE CustomerID = 'AK101';

-- Foreign Key Constraint - you can't insert an order for a customer that doesn't have an entry
-- in the Customers table
INSERT INTO Orders
	(CustomerID, EmployeeID, OrderDate, RequiredDate)
VALUES
	('AK999', 5, GETDATE(), DATEADD(dd, 10, GETDATE()));


-- DELETE

DELETE FROM Orders
WHERE CustomerID = 'AK101';

DELETE FROM Customers
WHERE CustomerID = 'AK101';

-- DELETE will be bound by the "referential integrity" rules that are in place
-- these are specified when the tables are created.
DELETE FROM Customers WHERE CustomerID = 'SAVEA';


SELECT * FROM Customers WHERE CustomerID = 'AK101';

-- UPDATE

UPDATE Customers
SET
	ContactName = 'Aidan', 
	PostalCode = 'T49DW99', 
	ContactTitle = 'Technical Trainer'
WHERE  CustomerID = 'AK101';

SELECT * INTO #akCustomers FROM Customers;

SELECT * FROM #akCustomers;

-- BE Careful!
-- no warnings
-- no "are you sure"
-- no way of undo!

-- this changes every record
UPDATE #akCustomers
SET ContactName = 'Aidan';

-- this deletes every record
DELETE FROM #akCustomers;







SELECT * FROM Orders;
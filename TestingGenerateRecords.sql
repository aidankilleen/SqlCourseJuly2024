EXEC [Ten Most Expensive Products];

EXEC CustOrderHist 'SAVEA'

EXEC SalesByCategory 'Beverages', 1997;

SELECT * FROM Categories;


SELECT * FROM akGetCountries();


SELECT * FROM dbo.akGetCustomerSummaryFn('SAVEA');



EXEC akGetCustomerSummary 'ANTON';

EXEC akGetCustomerSummary;


EXEC akCreateOrder 'AK101', 1, 2;

-- calling a stored procedure with named parameters
EXEC akCreateOrder 
	@CustomerID='SAVEA',
	@Quantity=1;


EXEC akExceptionInvestigation 'xxxxx';


EXEC akGenerateTestData 10000;


SELECT * FROM akMembers;


INSERT INTO akRecords
(MemberID, ProductName, Colour, Quantity)
VALUES(1, 'Pen', 'red', 100);


SELECT COUNT(*) FROM akRecords;


SELECT FLOOR(RAND() * 100);


SELECT TOP 1 MemberID FROM akMembers
ORDER BY NEWID();


SELECT NEWID();




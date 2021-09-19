
--We wrote a aql query that returns a customer name.
 select * from CustomersTable
 where CustomerName='Jane Doe'
 --The result was scanned at 700 pages.

 --We need to make this query more performant.
 --Sql generates a nonclustered query suggestion.
USE [CustomerDb]
GO
CREATE NONCLUSTERED INDEX IX_Get_Customer
ON [dbo].CustomerTable ([CustomerName])
INCLUDE ([BirthDate],[Age],[AgeGroup])
GO
--After using this query,hhe result was scanned at 49 pages.





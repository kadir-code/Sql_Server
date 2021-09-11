--Create procedure

CREATE PROCEDURE sp_GetProducts
AS
BEGIN
SELECT ProductID,ProductName,UnitPrice FROM Products
END

--Test Query

Execute sp_GetProducts

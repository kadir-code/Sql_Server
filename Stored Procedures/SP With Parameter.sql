--Create procedure

Create Procedure sp_CustomerSpend @id nchar(5)
As
Begin
	select od.OrderID,c.CompanyName,Sum(Quantity*UnitPrice*(1-Discount)) as Total from Customers c
	 Inner Join Orders o on o.CustomerID=c.CustomerID
	 Inner Join [Order Details] od on od.OrderID=o.OrderID
	 Where c.CustomerID=@id
	 Group By od.OrderID,c.CustomerID
End

--test query

Execute sp_CustomerSpend @id='ALFKI'
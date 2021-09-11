--Table returned functions

Create Function fn_listTable(@odId int)
returns table
as
return select * from [Order Details] where OrderID=@odId

--Test query

select * from dbo.fn_ListTable(10248)

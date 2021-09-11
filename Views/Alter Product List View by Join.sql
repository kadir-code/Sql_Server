--Update View

alter view ProductsList
as
select ProductName,UnitPrice,UnitsInStock,CategoryName
from products p
inner join categories c on c.CategoryID=p.CategoryID

--test query

select * from ProductsList
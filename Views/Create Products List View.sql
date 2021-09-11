--Create View

create view ProductsList
as
select ProductName,UnitPrice,UnitsInStock from products

--test query

select * from ProductsList


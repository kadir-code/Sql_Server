use Northwind

create table Products_Log(
[ProductID] int,
[ProductName]nvarchar(40),
[SupplierID]int,
[CategoryID]int,
[QuantityPerUnit]nvarchar(20),
[UnitPrice]money,
[UnitsInStock]smallint,
[UnitsOnOrder]smallint,
[ReorderLevel]smallint,
[Discontinued]bit,
[Log_ActionType]varchar(20),
[Log_Date]datetime,
[Log_UserName]varchar(50),
[Log_ProgramName]varchar(50),
[Log_HostName]varchar(50),
);


select * from Products_Log


create trigger trg_products_update
on Products
after update
as
begin
insert into Products_Log
(ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, Log_ActionType, Log_Date, Log_UserName, Log_ProgramName, Log_HostName)
select ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued,'update',GETDATE(),SUSER_NAME(),PROGRAM_NAME(),HOST_NAME()
from deleted

end

update Products
set UnitPrice=20.00
where ProductID=1


--check the changes
select * from Products_Log
select * from Products where ProductID=1


--create trigger for both processes
create trigger trg_products_delete
on Products
after delete
as
begin
insert into Products_Log
(ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, Log_ActionType, Log_Date, Log_UserName, Log_ProgramName, Log_HostName)
select ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued,'delete',GETDATE(),SUSER_NAME(),PROGRAM_NAME(),HOST_NAME()
from deleted

end

delete from Products where ProductID=79
select * from Products_Log

create trigger trg_products_delete_update
on Products
after delete,update
as
begin

declare @deletedCount as int
declare @insertedCount as int

select @deletedCount=count(*) from deleted
select @insertedCount=COUNT(*) from inserted

declare @logActionType as varchar(20)

if @deletedCount>0 and @insertedCount>0
	set @logActionType='UPDATE'

if @deletedCount>0 and @insertedCount=0
	set @logActionType='DELETE'


insert into Products_Log
(ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, Log_ActionType, Log_Date, Log_UserName, Log_ProgramName, Log_HostName)
select ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued,@logActionType,GETDATE(),SUSER_NAME(),PROGRAM_NAME(),HOST_NAME()
from deleted

end

select * from Products

update Products set UnitPrice=25 where ProductID=1

select*from Products where ProductID=1
select * from Products_Log where ProductID=1


--insteaf of trigger

create trigger trg_products_delete_update_instead_of
on Products
instead of delete,update
as
begin

declare @deletedCount as int
declare @insertedCount as int

select @deletedCount=count(*) from deleted
select @insertedCount=COUNT(*) from inserted

declare @logActionType as varchar(20)

if @deletedCount>0 and @insertedCount>0
	set @logActionType='UPDATE'

if @deletedCount>0 and @insertedCount=0
	set @logActionType='DELETE'


insert into Products_Log
(ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, Log_ActionType, Log_Date, Log_UserName, Log_ProgramName, Log_HostName)
select ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued,@logActionType,GETDATE(),SUSER_NAME(),PROGRAM_NAME(),HOST_NAME()
from deleted

end

--first disable previous trigger
alter table products disable trigger trg_products_delete_update

delete from Products where ProductID=1

select*from Products where ProductID=1
select * from Products_Log where ProductID=1





















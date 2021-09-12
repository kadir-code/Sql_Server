--Create a trigger that list the table after adding a record.

Create Trigger trg_listEmployeeRecords On Employees
After Insert
As
Begin
	Select * From Employees
End
 
 
--test query
insert into Employees(LastName,FirstName,Title,TitleOfCourtesy,City,Country)
values('Doe','Jane','It Manager','Mrs.','Texas','USA') 

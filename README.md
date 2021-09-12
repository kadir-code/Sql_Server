# Sql_Server
> This repository contains sql studies, stored procedures and sample databases.<br>
>> For more detailed information, you can check my gitbok page.
>> https://a-kadirerat.gitbook.io/sql/<br>
## Views<br>
It is used in places such as writing a complex query once and then calling a normal table, shortening the query time.<br>

```
Create View --NewTableName
As
Select --NeededColumns From --SelectedTable
```
## Functions
Functions are expressions that can return a specified value type. Functions have only output parameters and can only be used with a select query.

```
Create Function --functionName(parameters if exist)
Returns --Int-Nvachar
As
Begin
Return Select --Expression
End
```

## Stored Procedures
Stored procedures are expressions that are stored by the database and can be used again when needed after compilation. Since the expression is saved in the database, it does not need to be compiled again. Sp's do not always have to return a value. They have both input and output parameters. Sp's can perform all CRUD operations.

```
Create Procedure --procedureName
As
Begin
Select --NeededColumns From --SelectedTable
End

Execute --procedureName
```

## Triggers
A trigger structure is a special type of store procedure that automatically runs before or when certain events occur in a table in relational database management systems. The trigger structure is used when an insertion, update or deletion of a table occurs or before certain operations are requested to be performed on the same table or another table.
```
Create Trigger --triggerName On --SelectedTable
--After Insert or Instead Of
As
Begin
Select --NeededColumns From --SelectedTable
End

--Execution Query

```

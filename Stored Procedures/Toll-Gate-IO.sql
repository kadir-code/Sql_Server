

--Stored procedure for workers entering the turnstile by pressing a card
create database HR

use HR

create table Workers(
Id int identity(1,1) not null primary key,
WorkerCode nvarchar(20),
WorkerName nvarchar(50),
Gender varchar(1),
BirthDate date,
TcNo varchar(11),
WorkerBarcode uniqueidentifier,
);

create table WorkerTransactions(
Id int identity(1,1) not null primary key,
WorkerId int,
Date_ datetime,
IOType varchar(1),
GateId int,
);

--seeding tables
insert into Workers(WorkerCode, WorkerName, Gender, BirthDate, TcNo, WorkerBarcode)
values('15489632145','jane','e',getdate(),'23569874512',newid())

insert into WorkerTransactions (WorkerId, Date_, IOType, GateId)
values(4,'2020-04-12 13:00:00','c',5)


--1st solution
--sp writing about inputs and outputs, check if there is a record that matches the barcode given in this procedure
create procedure sp_CardControl @workerbarcode as varchar(50)
as
begin
	declare @workername as varchar(50)
	select @workername=WorkerName from Workers where @workerbarcode=WorkerBarcode
		if @workername is null
		begin
			raiserror('wrong entry',16,1)
			return
		end
		else
		begin
			select @workername
		end
end

execute sp_CardControl @workerbarcode='6DD76F44-BF2F-456B-A8BA-6E27599CCC77'

--2nd solution
create procedure sp_Turnike_IO
@workerbarcode as varchar(50)
@date as datetime 
@IOtype as varchar(1) --Is the user logging in or out?
@gateId as int 
as
begin
	--first check the correctness of the entered card
	declare @workername as varchar(50)
	declare @workerId as int
	select @workername=WorkerName,@workerId=Id from Workers
	where @workerbarcode=WorkerBarcode

	if @workerbarcode is null
	begin
		raiserror('card is invalid',16,1)
		return
	end

--the second condition checks the last move, if it's out does it push out again?
declare @lastIO as varchar(1)
select top 1 @lastIO=IOType from WorkerTransactions
where WorkerId=4
order by Date_ desc
	if @lastIO=@IOtype
	begin
		if @IOtype='i'
			raiserror('you seem to be already logged in, you cant log in',16,1)
			return
	end
	if @lastIO=@IOtype
	begin
		if @IOtype='o'
			raiserror('You look like youre already logged out, you cant log out',16,1)
			return
	end
	else-- if the operation is correct, the record is thrown for the entry.
	begin
		insert into WorkerTransactions(WorkerId,Date_,IOType,GateId)
		values(@workerId,@date,@IOtype,@gateId)
	end
select @workername as workername,@date as date_,@IOtype as IOtype
end

execute sp_Turnike_IO @date='2020-01-01 10:01:01',
@workerbarcode='6DD76F44-BF2F-456B-A8BA-6E27599CCC77',
@IOtype='o',
@gateId=7
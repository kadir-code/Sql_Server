

create database BankDb

use bankdb

create table Customers(
CustomerId	int identity(1,1) not null primary key,
CustomerName varchar(50),
);

create table Accounts(
AccountId	int identity(1,1) not null primary key,
CustomerId	int,
AccountNo varchar(50),
AccountName varchar(50),
Currency varchar(3),
);

insert into Accounts(CustomerId, AccountNo, AccountName, Currency)
values(2,'hesapNo2','max-account','tl')

create table AccountBalance(
AccountBalanceId	int identity(1,1) not null primary key,
AccountId	int ,
Balance float,
Currency varchar(3),
);

insert into AccountBalance(AccountId, Balance, Currency)
values(2,0,'tl')

create table MoneyTransactions(
MoneyTransactionId	int identity(1,1) not null primary key,
AccountId	int ,
TranType int,
Amount float,
Date_ datetime,
EftCode1 varchar(10),
EftCode varchar(10),
);


select c.CustomerName,a.AccountNo,a.AccountName,a.Currency,ab.Balance from AccountBalance ab
join Accounts a on a.AccountId=ab.AccountId
join Customers c on c.CustomerId=a.CustomerId


begin transaction 
insert into MoneyTransactions(AccountId, TranType, Amount, Date_, EftCode1, EftCode)
values(1,2,1000,getdate(),'1234560,','')
if @@ERROR>0
begin
	rollback tran
	return
end

update AccountBalance set Balance=Balance-1000 where AccountId=1
if @@ERROR>0
begin
	rollback tran
	return
end

insert into MoneyTransactions(AccountId, TranType, Amount, Date_, EftCode1, EftCode)
values(2,1,1000,getdate(),'1234560,','ab123456')
if @@ERROR>0
begin
	rollback tran
	return
end

update AccountBalance set Balance=Balance+1000 where AccountId=2
if @@ERROR>0
begin
	rollback tran
	return
end

commit transaction
--transaction log dosyasýndan mdf log dosyasýna kalýcý olarak yazdýrýr


--Until a transaction is made, no one else can access that data. The other query is held until the transaction is finished.
--the row used is locked to prevent those pulling other data from that table at the same time.
dbcc opentran---checks if there is an open transaction in the system

select * from Accounts
with (nolock)
where AccountId=1
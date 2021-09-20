

create database TRGExample

use trgexample

create table Items(
ItemId int identity(1,1) not null primary key,
ItemCode varchar(10),
ItemName varchar(50)
);

--seeding
insert into Items (ItemCode,ItemName) values('urun003','urun3')

create table ItemTransactions(
TrId int identity(1,1) not null primary key,
ItemId int,
Date_ datetime,
Amount int,
IOtype smallint
);

--seeding
declare @i as int=0
while @i<100000
begin

declare @ItemId as int
declare @date as datetime
declare @amount as int 
declare @IOtype as smallint

set @ItemId=round(rand()*3,0)--tablodaki 3 kayýttan birini seç
	if @ItemId=0
		set @ItemId=1--0-3 arasý seçer ;0 gelme durumu için

set @date=dateadd(day,-round(rand()*365,0),getdate())
set @amount=round(rand()*9,0)+1--1-10 arasý amount seçer
set @IOtype=round(rand()*1,0)+1

		insert into ItemTransactions(ItemId,Date_,Amount,IOtype)
		values(@ItemId,@date,@amount,@IOtype)
		set @i=@i+1
end

--idsi 1 olan ürünün yaptýðý giriþ ve çýkýþlar ve miktarý
select IOtype,sum(Amount) amount,COUNT(IOtype) totalIO from ItemTransactions
where ItemId=1
group by IOtype


--sub query ile her bir ürünün giriþ ile çýkýþ ürün sayýsýnýn farkýný aldýk
set statistics io on
select *,
(select sum(amount) from ItemTransactions
where ItemId=it.ItemId and IOtype=1)
-
(select sum(amount) from ItemTransactions
where ItemId=it.ItemId and IOtype=2) as stock
from Items it
--bu þekilde yaptýðýmýz sorgu 1712 sayfa arýyor
--stok bilgisini baþka tabloda tutmak daha performanslý olur

create table Stock(
StockId int primary key not null identity(1,1),
ItemId int,
Stock int
);

set statistics io on
select * from Stock
--ayrý tabloya alýnýnca sadece 2 page okuyor


--itemtransaction tablosunu truncate edip stoklarý da 0 layalým ki senaryoyu görelim
truncate table ItemTransactions

update stock set stock=0

create trigger trg_transactionInsert
on ItemTransactions
after insert
as
begin

declare @ItemId as int
declare @amount as int
declare @IOtype as smallint
select @ItemId=ItemId,@amount=Amount,@IOtype=IOtype from inserted
	if @IOtype=1
		update stock set Stock +=@amount where ItemId=@ItemId
	if @IOtype=2
		update stock set Stock=Stock-@amount where ItemId=@ItemId

end

--tablonun önce boþ olduðundan emin olalým
select * from Stock where ItemId=1
select * from ItemTransactions

insert into ItemTransactions (ItemId,Amount,Date_,IOtype)
values(1,5,getdate(),1)--5 kayýt girelim

insert into ItemTransactions (ItemId,Amount,Date_,IOtype)
values(1,20,getdate(),1)--20 kayýt girelim

insert into ItemTransactions (ItemId,Amount,Date_,IOtype)
values(1,10,getdate(),2)--10 kayýt silelim

select * from Stock where ItemId=1
select * from ItemTransactions
--ItemTransactions tablosuna veri giriþ çýkýþý olunca ayný anda stok tablosunun bilgileri güncelleniyor


-- miktarý güncellemek için tetikleyici oluþturun
create trigger trg_transactionInsert_update
on ItemTransactions
after update
as
begin

declare @ItemId as int
declare @IOtype as smallint
declare @oldamount as int
declare @newamount as int
declare @amount as int

select @ItemId=ItemId,@oldamount=Amount,@IOtype=IOtype from deleted

select @newamount=amount from inserted

select @amount=@oldamount-@newamount

if @IOtype=1
	update stock set Stock -=@amount where ItemId=@ItemId
if @IOtype=2
	update stock set Stock=Stock+@amount where ItemId=@ItemId
end

--normalde 5 giriþ yapmýþ olan bu kayýt 2 ile güncellenince aradaki fark kadar stok düþürdü
update ItemTransactions set amount=2 where TrId=1
Use master

--create sample table
Create Database SampleDb
Use SampleDb

create table Members(
[MemberId] int identity(1,1) not null primary key,
[Full Name] nvarchar(50)not null,
[Status]bit default 1,
);

--add records to table
insert into Members([Full Name]) values('Jane Doe')
insert into Members([Full Name]) values('Max Doe')

select * from Members

--creating trigger
Create Trigger trg_SoftDeleteMembers
on Members
Instead Of Delete
As
Begin
	Update Members
	Set Status=0
	From Members
	Inner Join  deleted on deleted.MemberId=Members.MemberId
End

--test triger
Delete Members Where MemberId=1


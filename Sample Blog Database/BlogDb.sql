*/
--------------------------------------------------------------------
Name   : BlogDb
Version: 1.0
--------------------------------------------------------------------
/*

use master

--create database

create database BlogDb

--create tables

use BlogDb

create table Members(
[MemberId] int identity(1,1) not null primary key,
[Full Name] nvarchar(50)not null,
[Status]bit null,
);

create table Authors(
[AuthorId] int identity(1,1) not null primary key,
[Full Name] nvarchar(50) not null,
);

create table AuthorsMembersDummyTable(
[MemberId] int foreign key references Members(MemberId),
[AuthorId] int foreign key references Authors(AuthorId),
);

create table SubCategories(
[SubCategoryId] int identity(1,1) not null primary key,
[Sub Category Name] nvarchar(20) null,
);

CREATE TABLE MainCategories(
[MainCategoryId] int identity(1,1) not null primary key,
[Category Name] nvarchar(20) not null,
[SubCategoryId] int foreign key references SubCategories(SubCategoryId),
);

create table Blogs(
[BlogId] int identity(1,1) not null primary key,
[Title] nvarchar not null,
[Context] nvarchar(max) not null,
[Status] bit null,
[AddDate] datetime not null default getdate(),
[SubCategoryId] int foreign key references SubCategories(SubCategoryId),
);


create table BlogsAuthorsDummyTable(
[BlogId] int foreign key references Blogs(BlogId),
[AuthorId] int foreign key references Authors(AuthorId),
);


























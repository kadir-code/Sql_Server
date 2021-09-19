
--write 10 number with using select
declare @i as int=0
while @i<10
begin
select @i
set @i=@i+1
end

--write 10 number with print
declare @i as int=0
while @i<10
begin
print @i
set @i=@i+1
end

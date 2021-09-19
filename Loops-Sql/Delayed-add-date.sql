
--It writes the date to the date column in the dates table with the date getdate function with a delay of 1 second.
declare @i as int=0
while @i<10
begin
	insert into History_(Date_) values(getdate())
	waitfor delay'00:00:01'
set @i=@i+1
end
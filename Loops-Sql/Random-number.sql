
--print random number and set message about interval
declare @num as int
set @num=round(rand()*10,0)
if @num<5 begin
	print @sayi
	print'number is less than 5'
end
else begin
	print @sayi
	print'number is bigger than 5'
end
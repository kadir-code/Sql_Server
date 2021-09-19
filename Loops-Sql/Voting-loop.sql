
declare @age as int
set @age=569
if @age>=18
	if @age>80
		print'too old to vote'
	else
		print'you can vote'
else
	print'too young to vote'
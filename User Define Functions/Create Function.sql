--Create function

Create Function Fn_Concatenate(@firstName Nvarchar(20),@surname Nvarchar(30))
Returns Nvarchar(51)
As
Begin
Return @firstName + Space(1)+ @surname
End

--test query
Select dbo.Fn_Concatenate('Jone','Doe')


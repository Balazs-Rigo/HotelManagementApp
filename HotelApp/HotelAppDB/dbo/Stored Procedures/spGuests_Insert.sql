CREATE PROCEDURE [dbo].[spGuests_Insert]
	@firstName nvarchar(50),
	@lastName nvarchar(50)
AS
BEGIN
	set nocount on;

	if not exists (select 1 from dbo.Guests where FirstName = @firstName and LastName = @lastName)
	BEGIN
		insert into dbo.Guests (FirstName, LastName)
		values (@firstName, @lastName);
	END

	select top 1 id,firstName, lastName
	from dbo.Guests
	where firstName = @firstName and lastName = @lastName;
END
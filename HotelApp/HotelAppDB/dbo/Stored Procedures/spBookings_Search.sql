CREATE PROCEDURE [dbo].[spBookings_Search]
	@lastName nvarchar(50),
	@startDate date
AS
BEGIN
	set nocount on;

	select [b].[Id], [b].[RoomId], [b].[GuestId], [b].[StartDate], [b].[EndDate], 
	[b].[CheckedIn], [b].[totalCost] ,[g].[FirstName], [g].[LastName],
	[r].[RoomNumber], [r].[RoomTypeId], [rt].[Title], [rt].[Desription], [rt].[Price]
	from dbo.bookings b
	inner join dbo.Guests g on b.GuestId = g.Id
	inner join dbo.Rooms r on b.RoomId = r.Id
	inner join dbo.RoomTypes rt on r.RoomTypeId = rt.Id
	where b.StartDate = @startDate and g.LastName = @lastName;
END
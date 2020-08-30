CREATE PROCEDURE [dbo].[spBookings_Insert]
	@roomId int,
	@guestId int,
	@startDate date,
	@endDate date,
	@totalCost money
AS
BEGIN
	set nocount on;

	insert into dbo.Bookings (RoomId, GuestId, StartDate, EndDate, TotalCost)
	values (@roomId, @guestId, @startDate, @endDate, @totalCost);
END
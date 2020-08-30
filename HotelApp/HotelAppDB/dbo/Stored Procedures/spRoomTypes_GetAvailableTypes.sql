CREATE PROCEDURE [dbo].[spRoomTypes_GetAvailableTypes]
	@startDate date,
	@enddate date
AS
begin
	set nocount on;

	select t.Id, t.Title, t.Desription, t.Price
	from dbo.Rooms r
	inner join dbo.RoomTypes t on t.id = r.RoomTypeId
	where r.id not in(
	select b.RoomId
	from dbo.Bookings b
	where ( @startDate < b.StartDate and @endDate > b.EndDate)
		or (b.StartDate <= @endDate and @endDate < b.EndDate)
		or (b.StartDate <= @startDate and @startDate< @endDate)
	)
	group by t.Id, t.Title, t.Desription, t.Price
end
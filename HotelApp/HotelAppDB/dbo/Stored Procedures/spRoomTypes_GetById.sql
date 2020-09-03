CREATE PROCEDURE [dbo].[spRoomTypes_GetById]
	@id int
AS
BEGIN
	set nocount on;

	select [Id], [Title], [Desription], [Price]
	from dbo.RoomTypes
	where Id = @id;
END
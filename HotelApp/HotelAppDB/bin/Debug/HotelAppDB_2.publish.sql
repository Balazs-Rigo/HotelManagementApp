﻿/*
Deployment script for HotelAppDB

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "HotelAppDB"
:setvar DefaultFilePrefix "HotelAppDB"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL14.MACKOSQLSERVER\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL14.MACKOSQLSERVER\MSSQL\DATA\"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
/*
The type for column EndDate in table [dbo].[Bookings] is currently  DATETIME2 (7) NOT NULL but is being changed to  DATE NOT NULL. Data loss could occur.

The type for column StartDate in table [dbo].[Bookings] is currently  DATETIME2 (7) NOT NULL but is being changed to  DATE NOT NULL. Data loss could occur.
*/

IF EXISTS (select top 1 1 from [dbo].[Bookings])
    RAISERROR (N'Rows were detected. The schema update is terminating because data loss might occur.', 16, 127) WITH NOWAIT

GO
PRINT N'Altering [dbo].[Bookings]...';


GO
ALTER TABLE [dbo].[Bookings] ALTER COLUMN [EndDate] DATE NOT NULL;

ALTER TABLE [dbo].[Bookings] ALTER COLUMN [StartDate] DATE NOT NULL;


GO
/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/

if not exists (select 1 from dbo.RoomTypes)
begin
    insert into dbo.RoomTypes(Title,Desription, Price)
    values ('King Size Bed','A room with a king-size bed and a window.',100),
    ('Two Queen Size Beds','A room with a two queen-size beds and a window.',115),
    ('Executive Suits','Two rooms, each with a king-size bed and window.',205)
end

if not exists (select 1 from dbo.rooms)
begin
    declare @roomId1 int;
    declare @roomId2 int;
    declare @roomId3 int;

    select @roomId1 = Id from dbo.RoomTypes where Title = 'King Size Bed';
    select @roomId2 = Id from dbo.RoomTypes where Title = 'Two Queen Size Beds';
    select @roomId3 = Id from dbo.RoomTypes where Title = 'Executive Suits';

    insert into dbo.Rooms (RoomNumber, RoomTypeId)
    values ('101',@roomId1),
    ('102',@roomId1),
    ('103',@roomId1),
    ('201',@roomId2),
    ('202',@roomId2),
    ('301',@roomId3);
end
GO

GO
PRINT N'Update complete.';


GO

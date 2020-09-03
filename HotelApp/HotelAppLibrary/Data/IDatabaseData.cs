﻿using HotelAppLibrary.Models;
using System;
using System.Collections.Generic;

namespace HotelAppLibrary.Data
{
    public interface IDatabaseData
    {
        void BookGuest(string firstName, string lastName, DateTime startDate, DateTime endDate, int roomTypeId);
        void CheckInGuest(int bookingId);
        List<RoomTypeModel> GetAvaliableRoomTypes(DateTime startDate, DateTime endDate);
        RoomTypeModel GetRoomTypeById(int id);
        List<BookingFullModel> SearchBookings(string lastName);
    }
}
import 'package:flutter/material.dart';
import '../models/booking.dart';

class BookingProvider extends ChangeNotifier {
  Booking? _currentBooking;

  Booking? get currentBooking => _currentBooking;

  void createBooking(Booking booking) {
    _currentBooking = booking;
    notifyListeners();
  }

  void clearBooking() {
    _currentBooking = null;
    notifyListeners();
  }
}

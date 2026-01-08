import 'car.dart';

class Booking {
  final String name;
  final String email;
  final String phone;
  final DateTime startDate;
  final DateTime endDate;
  final String location;
  final Car car;
  final double totalPrice;

  Booking({
    required this.name,
    required this.email,
    required this.phone,
    required this.startDate,
    required this.endDate,
    required this.location,
    required this.car,
    required this.totalPrice,
  });

  int get days => endDate.difference(startDate).inDays + 1;
}

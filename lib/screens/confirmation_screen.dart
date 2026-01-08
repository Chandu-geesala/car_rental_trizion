import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/booking_provider.dart';
import 'home_screen.dart';

class ConfirmationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final booking = Provider.of<BookingProvider>(context).currentBooking;

    if (booking == null) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 80, color: Colors.grey),
              SizedBox(height: 16),
              Text(
                'No booking found',
                style: TextStyle(fontSize: 18, color: Color(0xFF666666)),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Color(0xFFf5f5f5),
      appBar: AppBar(
        title: Text(
          'Booking Confirmed',
          style: TextStyle(color: Color(0xFF1a1a1a), fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Success Icon & Message
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Color(0xFFe8f4f3),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check_circle_rounded,
                      size: 80,
                      color: Color(0xFF15a89c),
                    ),
                  ),

                  SizedBox(height: 8),
                  Text(
                    'Your car has been successfully booked',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: Color(0xFF666666),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 12),

            // Booking Details Card
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.person_outline, color: Color(0xFF15a89c), size: 22),
                      SizedBox(width: 8),
                      Text(
                        'Personal Information',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1a1a1a),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  _buildDetailRow('Name', booking.name),
                  _buildDetailRow('Email', booking.email),
                  _buildDetailRow('Phone', booking.phone),
                  _buildDetailRow('Pickup Location', booking.location),
                ],
              ),
            ),

            SizedBox(height: 12),

            // Car Details Card
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.directions_car_rounded, color: Color(0xFF15a89c), size: 22),
                      SizedBox(width: 8),
                      Text(
                        'Car Details',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1a1a1a),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  _buildDetailRow('Car Model', '${booking.car.brand} ${booking.car.name}'),
                  _buildDetailRow('Transmission', booking.car.transmission),
                  _buildDetailRow('Fuel Type', booking.car.fuelType),
                  _buildDetailRow('Seats', '${booking.car.seats} People'),
                ],
              ),
            ),

            SizedBox(height: 12),

            // Rental Period Card
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.calendar_today, color: Color(0xFF15a89c), size: 22),
                      SizedBox(width: 8),
                      Text(
                        'Rental Period',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1a1a1a),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  _buildDetailRow(
                    'Start Date',
                    '${booking.startDate.day}/${booking.startDate.month}/${booking.startDate.year}',
                  ),
                  _buildDetailRow(
                    'End Date',
                    '${booking.endDate.day}/${booking.endDate.month}/${booking.endDate.year}',
                  ),
                  _buildDetailRow('Total Days', '${booking.days} days'),
                ],
              ),
            ),

            SizedBox(height: 12),

            // Payment Summary Card
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.receipt_long, color: Color(0xFF15a89c), size: 22),
                      SizedBox(width: 8),
                      Text(
                        'Payment Summary',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1a1a1a),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  _buildDetailRow('Price per day', '₹${booking.car.pricePerDay}'),
                  _buildDetailRow('Number of days', '${booking.days}'),
                  SizedBox(height: 12),
                  Divider(color: Color(0xFFe0e0e0)),
                  SizedBox(height: 12),
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Color(0xFFe8f4f3),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Color(0xFF15a89c).withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Amount',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1a1a1a),
                          ),
                        ),
                        Text(
                          '₹${booking.totalPrice.toStringAsFixed(0)}',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF15a89c),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 12),

            // Note Card
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFFfff8e1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Color(0xFFffd54f), width: 1),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.info_outline, color: Color(0xFFf57c00), size: 20),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Please carry a valid driving license and ID proof at the time of pickup.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF666666),
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 80),
          ],
        ),
      ),

      // Bottom Button
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: ElevatedButton(
            onPressed: () {
              Provider.of<BookingProvider>(context, listen: false).clearBooking();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => HomeScreen()),
                    (route) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF15a89c),
              padding: EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: Text(
              'Back to Home',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF666666),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1a1a1a),
              ),
            ),
          ),
        ],
    ),
    );
  }
}

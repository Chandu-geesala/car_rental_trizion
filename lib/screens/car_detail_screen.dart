import 'package:flutter/material.dart';
import '../models/car.dart';
import 'booking_form_screen.dart';

class CarDetailScreen extends StatelessWidget {
  final Car car;

  CarDetailScreen({required this.car});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf5f5f5),
      body: CustomScrollView(
        slivers: [
          // App Bar with Image
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: Colors.white,
            leading: Container(
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Color(0xFF1a1a1a)),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    car.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: Color(0xFFe8f4f3),
                      child: Icon(
                        Icons.directions_car_rounded,
                        size: 100,
                        color: Color(0xFF15a89c),
                      ),
                    ),
                  ),
                  // Gradient Overlay
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.7),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                  // // Rating & Availability Badges
                  // Positioned(
                  //   top: 70,
                  //   right: 16,
                  //   child: Container(
                  //     padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  //     decoration: BoxDecoration(
                  //       color: car.isAvailable ? Color(0xFF15a89c) : Colors.red[400],
                  //       borderRadius: BorderRadius.circular(20),
                  //       boxShadow: [
                  //         BoxShadow(
                  //           color: Colors.black.withOpacity(0.2),
                  //           blurRadius: 8,
                  //           offset: Offset(0, 2),
                  //         ),
                  //       ],
                  //     ),
                  //     child: Text(
                  //       car.isAvailable ? 'Available' : 'Not Available',
                  //       style: TextStyle(
                  //         color: Colors.white,
                  //         fontSize: 13,
                  //         fontWeight: FontWeight.bold,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // Positioned(
                  //   top: 280,
                  //   left: 16,
                  //   child: Container(
                  //     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  //     decoration: BoxDecoration(
                  //       color: Colors.white,
                  //       borderRadius: BorderRadius.circular(20),
                  //       boxShadow: [
                  //         BoxShadow(
                  //           color: Colors.black.withOpacity(0.2),
                  //           blurRadius: 8,
                  //           offset: Offset(0, 2),
                  //         ),
                  //       ],
                  //     ),
                  //     child: Row(
                  //       children: [
                  //         Icon(Icons.star, color: Colors.amber, size: 18),
                  //         SizedBox(width: 4),
                  //         Text(
                  //           '${car.rating}',
                  //           style: TextStyle(
                  //             fontWeight: FontWeight.bold,
                  //             fontSize: 14,
                  //             color: Color(0xFF1a1a1a),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Car Name & Brand
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          car.name,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1a1a1a),
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          car.brand,
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF666666),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Divider(height: 1, thickness: 1, color: Color(0xFFf0f0f0)),

                  // Specifications
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Specifications',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1a1a1a),
                          ),
                        ),
                        SizedBox(height: 16),

                        // Spec Cards Grid
                        Row(
                          children: [
                            Expanded(
                              child: _buildSpecCard(
                                Icons.airline_seat_recline_normal,
                                'Seats',
                                '${car.seats} People',
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: _buildSpecCard(
                                Icons.settings,
                                'Transmission',
                                car.transmission,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: _buildSpecCard(
                                Icons.local_gas_station,
                                'Fuel Type',
                                car.fuelType,
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: _buildSpecCard(
                                Icons.star_rounded,
                                'Rating',
                                '${car.rating}/5.0',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  Divider(height: 1, thickness: 1, color: Color(0xFFf0f0f0)),

                  // Price Section
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Rental Price',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1a1a1a),
                          ),
                        ),
                        SizedBox(height: 16),
                        Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Color(0xFFe8f4f3),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Color(0xFF15a89c).withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Price per day',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF666666),
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    '₹${car.pricePerDay}',
                                    style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF15a89c),
                                    ),
                                  ),
                                ],
                              ),

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Features Section
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Features',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1a1a1a),
                          ),
                        ),
                        SizedBox(height: 16),
                        _buildFeatureItem('Air Conditioning'),
                        _buildFeatureItem('Bluetooth Connectivity'),
                        _buildFeatureItem('GPS Navigation'),
                        _buildFeatureItem('Child Safety Seats Available'),
                        _buildFeatureItem('24/7 Roadside Assistance'),
                      ],
                    ),
                  ),

                  SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ],
      ),

      // Bottom Book Button
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
            onPressed: car.isAvailable
                ? () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BookingFormScreen(car: car),
                ),
              );
            }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF15a89c),
              disabledBackgroundColor: Colors.grey[300],
              padding: EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: Text(
              car.isAvailable ? 'Book Now' : 'Not Available',
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

  Widget _buildSpecCard(IconData icon, String label, String value) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFf8f8f8),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFFe0e0e0), width: 1),
      ),
      child: Column(
        children: [
          Icon(icon, color: Color(0xFF15a89c), size: 28),
          SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF999999),
            ),
          ),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1a1a1a),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(String feature) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Color(0xFF15a89c),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check,
              color: Colors.white,
              size: 16,
            ),
          ),
          SizedBox(width: 12),
          Text(
            feature,
            style: TextStyle(
              fontSize: 15,
              color: Color(0xFF1a1a1a),
            ),
          ),
        ],
      ),
    );
  }
}

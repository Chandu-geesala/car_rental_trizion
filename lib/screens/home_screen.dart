import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../models/car.dart';
import 'car_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Car> allCars = MockData.getCars();
  List<Car> filteredCars = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredCars = allCars;
    _searchController.addListener(_filterCars);
  }

  void _filterCars() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        filteredCars = allCars;
      } else {
        filteredCars = allCars.where((car) {
          return car.name.toLowerCase().contains(query) ||
              car.brand.toLowerCase().contains(query) ||
              car.fuelType.toLowerCase().contains(query) ||
              car.transmission.toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf5f5f5),
      body: CustomScrollView(
        slivers: [
          // Scrollable AppBar with Logo, Title, and Logout
          SliverAppBar(
            expandedHeight: 60,
            floating: true,
            pinned: false,
            backgroundColor: Colors.white,
            leading: Padding(
              padding: EdgeInsets.all(8),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF15a89c).withOpacity(0.2),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/logo.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            title: Text(
              'Car Rental Task',
              style: TextStyle(
                color: Color(0xFF1a1a1a),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            centerTitle: true,
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 8),
                child: TextButton.icon(
                  onPressed: () {
                    // Logout functionality (not implemented)
                  },
                  icon: Icon(
                    Icons.logout,
                    size: 20,
                    color: Colors.red[400],
                  ),
                  label: Text(
                    '',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.red[400],
                    ),
                  ),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  ),
                ),
              ),
            ],

          ),

          // Search Bar
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(16),
              color: Colors.white,
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search cars...',
                  hintStyle: TextStyle(color: Color(0xFF999999)),
                  prefixIcon: Icon(Icons.search, color: Color(0xFF15a89c)),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                    icon: Icon(Icons.clear, color: Color(0xFF999999)),
                    onPressed: () {
                      _searchController.clear();
                    },
                  )
                      : null,
                  filled: true,
                  fillColor: Color(0xFFf5f5f5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 0),
                ),
              ),
            ),
          ),


          // Car List
          filteredCars.isEmpty
              ? SliverToBoxAdapter(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(40),
                child: Column(
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 80,
                      color: Color(0xFFcccccc),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'No cars found',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF666666),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Try searching with different keywords',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF999999),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
              : SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  final car = filteredCars[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CarDetailScreen(car: car),
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Car Image
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(16)),
                                child: Image.network(
                                  car.imageUrl,
                                  height: 180,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => Container(
                                    height: 180,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFe8f4f3),
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(16)),
                                    ),
                                    child: Icon(
                                      Icons.directions_car_rounded,
                                      size: 60,
                                      color: Color(0xFF15a89c),
                                    ),
                                  ),
                                ),
                              ),
                              // Availability Badge
                              Positioned(
                                top: 12,
                                right: 12,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: car.isAvailable
                                        ? Color(0xFF15a89c)
                                        : Colors.red[400],
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                        Colors.black.withOpacity(0.2),
                                        blurRadius: 8,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    car.isAvailable
                                        ? 'Available'
                                        : 'Booked',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              // Rating Badge
                              Positioned(
                                top: 12,
                                left: 12,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                        Colors.black.withOpacity(0.1),
                                        blurRadius: 8,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Icons.star,
                                          color: Colors.amber, size: 16),
                                      SizedBox(width: 4),
                                      Text(
                                        '${car.rating}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                          color: Color(0xFF1a1a1a),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // Car Details
                          Padding(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Car Name & Brand
                                Text(
                                  car.name,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1a1a1a),
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  car.brand,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                  ),
                                ),
                                SizedBox(height: 12),

                                // Car Specs
                                Row(
                                  children: [
                                    _buildSpecItem(
                                        Icons.airline_seat_recline_normal,
                                        '${car.seats}'),
                                    SizedBox(width: 16),
                                    _buildSpecItem(
                                        Icons.settings,
                                        car.transmission == 'Automatic'
                                            ? 'Auto'
                                            : 'Manual'),
                                    SizedBox(width: 16),
                                    _buildSpecItem(Icons.local_gas_station,
                                        car.fuelType),
                                  ],
                                ),
                                SizedBox(height: 16),

                                // Price & Button
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '₹${car.pricePerDay}',
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF15a89c),
                                          ),
                                        ),
                                        Text(
                                          'per day',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFF999999),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height: 45,
                                      child: ElevatedButton(
                                        onPressed: car.isAvailable
                                            ? () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) =>
                                                  CarDetailScreen(
                                                      car: car),
                                            ),
                                          );
                                        }
                                            : null,
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                          Color(0xFF15a89c),
                                          disabledBackgroundColor:
                                          Colors.grey[300],
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(12),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 24),
                                          elevation: 0,
                                        ),
                                        child: Text(
                                          'Book Now',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
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
                  );
                },
                childCount: filteredCars.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Color(0xFF666666)),
        SizedBox(width: 6),
        Text(
          text,
          style: TextStyle(
            fontSize: 13,
            color: Color(0xFF666666),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

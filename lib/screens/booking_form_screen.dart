import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../models/car.dart';
import '../models/booking.dart';
import '../providers/booking_provider.dart';
import 'confirmation_screen.dart';

class BookingFormScreen extends StatefulWidget {
  final Car car;

  BookingFormScreen({required this.car});

  @override
  _BookingFormScreenState createState() => _BookingFormScreenState();
}

class _BookingFormScreenState extends State<BookingFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _locationController = TextEditingController();

  DateTime? _startDate;
  DateTime? _endDate;

  // Email validation
  bool _isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Color(0xFF15a89c),
              onPrimary: Colors.white,
              onSurface: Color(0xFF1a1a1a),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
          if (_endDate != null && _endDate!.isBefore(_startDate!)) {
            _endDate = null;
          }
        } else {
          _endDate = picked;
        }
      });
    }
  }

  void _submitBooking() {
    if (_formKey.currentState!.validate() && _startDate != null && _endDate != null) {
      final days = _endDate!.difference(_startDate!).inDays + 1;
      final totalPrice = widget.car.pricePerDay * days;

      final booking = Booking(
        name: _nameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        startDate: _startDate!,
        endDate: _endDate!,
        location: _locationController.text,
        car: widget.car,
        totalPrice: totalPrice,
      );

      Provider.of<BookingProvider>(context, listen: false).createBooking(booking);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => ConfirmationScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill all fields and select dates'),
          backgroundColor: Colors.red[400],
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf5f5f5),
      appBar: AppBar(
        title: Text(
          'Booking Form',
          style: TextStyle(color: Color(0xFF1a1a1a), fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF1a1a1a)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus(); // Dismiss keyboard
          },
          behavior: HitTestBehavior.opaque,
          child: SingleChildScrollView(
        child: Column(
          children: [
            // Car Info Card with Image
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  // Car Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      widget.car.imageUrl,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Color(0xFFe8f4f3),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.directions_car_rounded,
                          size: 40,
                          color: Color(0xFF15a89c),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.car.name,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1a1a1a),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          widget.car.brand,
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF666666),
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 16),
                            SizedBox(width: 4),
                            Text(
                              '${widget.car.rating}',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1a1a1a),
                              ),
                            ),
                            SizedBox(width: 12),
                            Text(
                              '₹${widget.car.pricePerDay}/day',
                              style: TextStyle(
                                fontSize: 14,
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

            SizedBox(height: 12),

            // Form Section
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Personal Information',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1a1a1a),
                      ),
                    ),
                    SizedBox(height: 16),

                    // Name Field
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Full Name',
                        labelStyle: TextStyle(color: Color(0xFF666666)),
                        prefixIcon: Icon(Icons.person_outline, color: Color(0xFF15a89c)),
                        filled: true,
                        fillColor: Color(0xFFf8f8f8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Color(0xFFe0e0e0), width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Color(0xFF15a89c), width: 2),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.red[400]!, width: 1),
                        ),
                      ),
                      validator: (val) {
                        if (val == null || val.trim().isEmpty) {
                          return 'Enter your name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),

                    // Email Field with validation
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email Address',
                        labelStyle: TextStyle(color: Color(0xFF666666)),
                        prefixIcon: Icon(Icons.email_outlined, color: Color(0xFF15a89c)),
                        filled: true,
                        fillColor: Color(0xFFf8f8f8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Color(0xFFe0e0e0), width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Color(0xFF15a89c), width: 2),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.red[400]!, width: 1),
                        ),
                      ),
                      validator: (val) {
                        if (val == null || val.trim().isEmpty) {
                          return 'Enter your email';
                        }
                        if (!_isValidEmail(val.trim())) {
                          return 'Enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),

                    // Phone Field - Only 10 digits
                    TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ],
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        labelStyle: TextStyle(color: Color(0xFF666666)),
                        prefixIcon: Icon(Icons.phone_outlined, color: Color(0xFF15a89c)),
                        counterText: '',
                        filled: true,
                        fillColor: Color(0xFFf8f8f8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Color(0xFFe0e0e0), width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Color(0xFF15a89c), width: 2),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.red[400]!, width: 1),
                        ),
                      ),
                      validator: (val) {
                        if (val == null || val.trim().isEmpty) {
                          return 'Enter your phone number';
                        }
                        if (val.trim().length != 10) {
                          return 'Phone number must be 10 digits';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),

                    // Location Field
                    TextFormField(
                      controller: _locationController,
                      decoration: InputDecoration(
                        labelText: 'Pickup Location',
                        labelStyle: TextStyle(color: Color(0xFF666666)),
                        prefixIcon: Icon(Icons.location_on_outlined, color: Color(0xFF15a89c)),
                        filled: true,
                        fillColor: Color(0xFFf8f8f8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Color(0xFFe0e0e0), width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Color(0xFF15a89c), width: 2),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.red[400]!, width: 1),
                        ),
                      ),
                      validator: (val) {
                        if (val == null || val.trim().isEmpty) {
                          return 'Enter pickup location';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 12),

            // Rental Period Section (rest of the code remains the same...)
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Rental Period',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1a1a1a),
                    ),
                  ),
                  SizedBox(height: 16),

                  // Date Pickers
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => _selectDate(context, true),
                          child: Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Color(0xFFf8f8f8),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: _startDate != null ? Color(0xFF15a89c) : Color(0xFFe0e0e0),
                                width: 1,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.calendar_today, size: 18, color: Color(0xFF15a89c)),
                                    SizedBox(width: 8),
                                    Text(
                                      'Start Date',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF999999),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Text(
                                  _startDate == null
                                      ? 'Select date'
                                      : '${_startDate!.day}/${_startDate!.month}/${_startDate!.year}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1a1a1a),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => _selectDate(context, false),
                          child: Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Color(0xFFf8f8f8),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: _endDate != null ? Color(0xFF15a89c) : Color(0xFFe0e0e0),
                                width: 1,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.calendar_today, size: 18, color: Color(0xFF15a89c)),
                                    SizedBox(width: 8),
                                    Text(
                                      'End Date',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF999999),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Text(
                                  _endDate == null
                                      ? 'Select date'
                                      : '${_endDate!.day}/${_endDate!.month}/${_endDate!.year}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1a1a1a),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Price Summary
                  if (_startDate != null && _endDate != null) ...[
                    SizedBox(height: 20),
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
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total Days',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF666666),
                                ),
                              ),
                              Text(
                                '${_endDate!.difference(_startDate!).inDays + 1} days',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1a1a1a),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          Divider(color: Color(0xFF15a89c).withOpacity(0.3)),
                          SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total Price',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1a1a1a),
                                ),
                              ),
                              Text(
                                '₹${widget.car.pricePerDay * (_endDate!.difference(_startDate!).inDays + 1)}',
                                style: TextStyle(
                                  fontSize: 24,
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
                ],
              ),
            ),

            SizedBox(height: 80),
          ],
        ),
      ),
        ),

      // Bottom Confirm Button
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
            onPressed: _submitBooking,
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF15a89c),
              padding: EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: Text(
              'Confirm Booking',
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
}

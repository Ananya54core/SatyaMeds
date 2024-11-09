import 'package:flutter/material.dart';
import 'package:satyameds/appointmet/booking_success.dart';


class AppointmentBookingScreen extends StatefulWidget {
  @override
  _AppointmentBookingScreenState createState() => _AppointmentBookingScreenState();
}

class _AppointmentBookingScreenState extends State<AppointmentBookingScreen> {
  final _formKey = GlobalKey<FormState>();
  String _selectedDoctor = 'Dr. Atish Mehta'; // Default selection
  String _selectedDay = 'Monday'; // Default selection based on availability
  String _selectedSlot = '09:00 - 10:00'; // Default slot

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final Map<String, Map<String, List<String>>> doctorAvailability = {
    'Dr. Atish Mehta': {
      'Monday': ['09:00 - 10:00', '14:00 - 15:00'],
      'Wednesday': ['09:00 - 10:00', '14:00 - 15:00'],
      'Friday': ['09:00 - 10:00', '14:00 - 15:00'],
    },
    'Dr. Romal Jindal': {
      'Tuesday': ['10:00 - 11:00', '16:00 - 17:00'],
      'Thursday': ['10:00 - 11:00', '16:00 - 17:00'],
    },
    'Dr. Aniket Shukla': {
      'Wednesday': ['11:00 - 12:00', '17:00 - 18:00'],
      'Saturday': ['11:00 - 12:00', '17:00 - 18:00'],
    },
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/onboarding/slot.jpg'), // Replace with your background image path
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Form
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: SingleChildScrollView(
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  color: Colors.white.withOpacity(0.5), // Making the container transparent
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Appointment Details',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.indigoAccent),
                          ),
                          SizedBox(height: 16),
                          DropdownButtonFormField<String>(
                            value: _selectedDoctor,
                            decoration: InputDecoration(labelText: 'Select Doctor'),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedDoctor = newValue!;
                                _selectedDay = doctorAvailability[_selectedDoctor]!.keys.first;
                                _selectedSlot = doctorAvailability[_selectedDoctor]![_selectedDay]!.first;
                              });
                            },
                            items: doctorAvailability.keys.map((String doctor) {
                              return DropdownMenuItem<String>(
                                value: doctor,
                                child: Text(doctor),
                              );
                            }).toList(),
                          ),
                          SizedBox(height: 16),
                          DropdownButtonFormField<String>(
                            value: _selectedDay,
                            decoration: InputDecoration(labelText: 'Select Day'),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedDay = newValue!;
                                _selectedSlot = doctorAvailability[_selectedDoctor]![_selectedDay]!.first;
                              });
                            },
                            items: doctorAvailability[_selectedDoctor]!.keys.map((String day) {
                              return DropdownMenuItem<String>(
                                value: day,
                                child: Text(day),
                              );
                            }).toList(),
                          ),
                          SizedBox(height: 16),
                          DropdownButtonFormField<String>(
                            value: _selectedSlot,
                            decoration: InputDecoration(labelText: 'Select Time Slot'),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedSlot = newValue!;
                              });
                            },
                            items: doctorAvailability[_selectedDoctor]![_selectedDay]!.map((String slot) {
                              return DropdownMenuItem<String>(
                                value: slot,
                                child: Text(slot),
                              );
                            }).toList(),
                          ),
                          SizedBox(height: 16),
                          // Email Input
                          TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(color: Colors.black), // Text color
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16),
                          // Phone Number Input
                          TextFormField(
                            controller: _phoneController,
                            decoration: InputDecoration(
                              labelText: 'Phone Number',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            ),
                            keyboardType: TextInputType.phone,
                            style: TextStyle(color: Colors.black), // Text color
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your phone number';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 24),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                              backgroundColor: Colors.indigoAccent, // Changed teal to light green
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // Process the booking
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BookingSuccessScreen(),
                                  ),
                                );
                              }
                            },
                            child: Center(
                              child: Text(
                                'Book Appointment',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



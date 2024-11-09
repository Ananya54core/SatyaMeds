import 'dart:convert'; // For JSON parsing
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'booking_schedule.dart';
import 'booking_success.dart';
import 'doctor_modalclass.dart';

/// Example JSON data (you would normally load this from a file or API)
const String jsonData = '''
{
  "doctors": [
    {
      "id": 1,
      "name": "Dr. John Doe",
      "speciality": "Cardiologist",
      "availability": [
        {
          "date": "2024-09-12",
          "time_slots": ["09:00", "10:30", "14:00", "16:00"]
        }
      ]
    },
    {
      "id": 2,
      "name": "Dr. Sarah Smith",
      "speciality": "Dermatologist",
      "availability": [
        {
          "date": "2024-09-18",
          "time_slots": ["08:30", "09:30", "12:00", "14:00"]
        },
        {
          "date": "2024-09-19",
          "time_slots": ["10:00", "11:30", "15:00"]
        }
      ]
    }
  ]
}
''';

/// Parses the JSON data into a list of [Doctor] objects.
List<Doctor> parseDoctors(String jsonString) {
  final Map<String, dynamic> data = json.decode(jsonString);
  final List<dynamic> doctorsJson = data['doctors'];
  return doctorsJson.map((json) => Doctor.fromJson(json)).toList();
}

/// Checks if the doctor is available on the given [date] at the given [time].
///
/// If the date or time is not available, an exception is thrown.
void checkDoctorAvailability(Doctor doctor, String date, String time) {
  try {
    // Step 1: Find the availability for the given date
    Availability availabilityForDate = doctor.availability.firstWhere(
          (availability) => availability.date == date,
      orElse: () => throw Exception('Date not available'),
    );

    // Step 2: Check if the requested time is within the available time slots
    if (availabilityForDate.timeSlots.contains(time)) {
      print('Date and time are available');
    } else {
      throw Exception('Time not available');
    }
  } catch (e) {
    print(e.toString());
    // You might want to notify the user here, using a dialog or other UI element.
  }
}

/// Handles the booking process for a doctor on the selected [date] and [time].
///
/// Navigates to the appropriate screen based on availability.
void handleBooking(Doctor doctor, DateTime selectedDate, TimeOfDay selectedTime) {
  String date = "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";
  String time = "${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}";

  try {
    // Check the availability of the doctor for the selected date and time
    checkDoctorAvailability(doctor, date, time);

    // If no exception is thrown, navigate to the booking success screen
    print("Navigating to Booking Success Screen");
    Get.to(() => const BookingSuccessScreen());
  } catch (e) {
    // If an exception is thrown, navigate to the doctor's time table screen
    print(e.toString());
    print("Navigating to Doctor's Time Table Screen");
    Get.to(() => DoctorScheduleScreen(doctor: doctor));
  }
}

void main() {
  // Parse the JSON data into Doctor objects
  List<Doctor> doctors = parseDoctors(jsonData);

  // Example: Checking availability for Dr. John Doe on a specific date and time
  Doctor doctorJohnDoe = doctors.firstWhere((doctor) => doctor.name == "Dr. John Doe");

  // Check availability for a specific date and time
  checkDoctorAvailability(doctorJohnDoe, "2024-09-12", "09:00"); // Should print "Date and time are available"
  checkDoctorAvailability(doctorJohnDoe, "2024-09-12", "11:00"); // Should print "Time not available"

  // Handle booking for a specific date and time
  DateTime selectedDate = DateTime(2024, 9, 12); // September 12, 2024
  TimeOfDay selectedTime = TimeOfDay(hour: 9, minute: 0); // 09:00 AM
  handleBooking(doctorJohnDoe, selectedDate, selectedTime); // Should navigate to Booking Success Screen
}

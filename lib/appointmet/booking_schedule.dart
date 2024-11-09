// screens/doctor_schedule_screen.dart
import 'package:flutter/material.dart';

import 'doctor_modalclass.dart';

class DoctorScheduleScreen extends StatelessWidget {
  final Doctor doctor;

  DoctorScheduleScreen({required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor Schedule'),
      ),
      body: ListView.builder(
        itemCount: doctor.availability.length,
        itemBuilder: (context, index) {
          var availability = doctor.availability[index];
          return ListTile(
            title: Text('Date: ${availability.date}'),
            subtitle: Text('Time Slots: ${availability.timeSlots.join(', ')}'),
          );
        },
      ),
    );
  }
}

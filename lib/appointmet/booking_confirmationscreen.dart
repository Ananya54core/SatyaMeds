import 'package:flutter/material.dart';

class BookingConfirmationScreen extends StatelessWidget {
  final bool isAppointmentSoon;

  const BookingConfirmationScreen({super.key, required this.isAppointmentSoon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.indigoAccent,
              size: 100,
            ),
            const SizedBox(height: 20),
            Text(
              isAppointmentSoon
                  ? 'Your booking is confirmed and the appointment is soon. Redirecting to chat...'
                  : 'Your booking is confirmed. Redirecting to home...',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.indigoAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

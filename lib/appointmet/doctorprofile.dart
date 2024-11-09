import 'package:flutter/material.dart';

import 'formfill.dart';
import 'package:get/get.dart';

class DoctorProfileScreen extends StatelessWidget {
  const DoctorProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Doctor's Image
            const SizedBox(height: 40,),
            Container(
              height: 250, // Adjusted height for portrait image
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                image: const DecorationImage(
                  image: AssetImage('assets/onboarding/dr1.png'), // Placeholder image
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Doctor's Name and Specialty
            const Text(
              'Dr. Atish Mehta',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.indigoAccent,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            const Text(
              'Ayurveda Specialist',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            // Doctor's Bio
            const Text(
              'Dr. Atish Mehta is a renowned Ayurveda specialist with over 15 years of experience in treating various health conditions using traditional Ayurvedic methods. He is known for his compassionate care and holistic approach to health and wellness.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.indigoAccent,
              ),
            ),
            const SizedBox(height: 24),
            // User Reviews
            const Text(
              'User Reviews',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.indigoAccent,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(5, (index) {
                return const Icon(
                  Icons.star,
                  color: Colors.orange,
                  size: 20,
                );
              }),
            ),
            const SizedBox(height: 4),
            const Text(
              '4.8 (120 reviews)',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            // Contact Information
            const Text(
              'Contact Information',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.indigoAccent,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Email: dr.atishmehta@example.com',
              style: TextStyle(
                fontSize: 14,
                color: Colors.indigoAccent,
              ),
            ),
            const SizedBox(height: 14),
            // Book Appointment Button
            ElevatedButton(
              onPressed: ()=>Get.to(()=> AppointmentBookingScreen()),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.indigoAccent,
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              child: const Text(
                'Book Appointment',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

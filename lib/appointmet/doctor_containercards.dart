import 'package:flutter/material.dart';

import 'doctorprofile.dart';

class AppointmentScreenCard extends StatelessWidget {
  AppointmentScreenCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctors'),
        backgroundColor: Colors.indigo[500],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  _buildDoctorsGrid(),
                ],
              ),
            ),
            // Book Appointment Button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Logic to book an appointment
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  backgroundColor: Colors.indigo[500],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: const Text(
                  'Book Appointment',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to build doctors grid
  Widget _buildDoctorsGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: _doctors.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // 3 doctors per row
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        childAspectRatio: 3 / 4,
      ),
      itemBuilder: (context, index) {
        final doctor = _doctors[index];
        return _buildDoctorProfileContainer(context, doctor);
      },
    );
  }

  // Function to build doctor profile container similar to shopkeeper card
  Widget _buildDoctorProfileContainer(
      BuildContext context, Map<String, String> doctor) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DoctorProfileScreen(
              //name: doctor['name']!,
              //specialty: doctor['specialty']!,
              //imagePath: doctor['imagePath']!,
            ),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 4.0,
        child: Column(
          children: [
            // Doctor Image
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset(
                doctor['imagePath']!,
                height: 70,
                width: 70,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8),
            // Doctor Name
            Flexible(
              child: Text(
                doctor['name']!,
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo[500],
                ),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 5),
            // Doctor Specialty
            Flexible(
              child: Text(
                doctor['specialty']!,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey[700],
                ),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Sample data for doctors
  final List<Map<String, String>> _doctors = [
    {
      'name': 'Dr. Atish Mehta',
      'specialty': 'Ayurveda specialist',
      'imagePath': 'assets/onboarding/dr1.png',
    },
    {
      'name': 'Dr. Romal Jindal',
      'specialty': 'Pedriatrician',
      'imagePath': 'assets/onboarding/dr2.png',
    },
    {
      'name': 'Dr. Aniket Shukla',
      'specialty': 'Skin speacilist',
      'imagePath': 'assets/onboarding/dr2.png',
    },
  ];
}


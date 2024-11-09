import 'package:flutter/material.dart';
import 'package:satyameds/mainscreen/promoslider.dart';
import 'package:satyameds/utils/constants/image_strings.dart';
import 'doctorprofile.dart';

class AppointmentScreen extends StatelessWidget {
  AppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 40), // Space between the top and banners
            const TPromoSlider(
              banners: [
                TImages.banner1,
                TImages.banner3,
              ],
            ),
            const SizedBox(height: 30.0), // Increased space between banner and heading
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0), // Padding for heading
              child: Text(
                "Our Medical Specialities",
                style: TextStyle(
                  fontSize: 24, // Increased font size for heading
                  fontWeight: FontWeight.bold,
                  color: Colors.indigoAccent,
                ),
              ),
            ),
            const SizedBox(height: 20.0), // Space between heading and icons
            // Horizontal Scrollable Icons Section
            Container(
              height: 140, // Increased height for larger icons
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _specialities.length,
                itemBuilder: (context, index) {
                  final speciality = _specialities[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0), // Increased padding around icons
                    child: _buildSpecialityIcon(speciality),
                  );
                },
              ),
            ),
            const SizedBox(height: 2),
            Expanded(
              child: _buildDoctorsSection(),
            ),
          ],
        ),
      ),
    );
  }

  // Function to build a circular icon with an image and label
  Widget _buildSpecialityIcon(Map<String, String> speciality) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40, // Increased size of the circular icon
          backgroundImage: AssetImage(speciality['imagePath']!),
        ),
        const SizedBox(height: 9), // Adjust spacing between icon and text
        Text(
          speciality['name']!,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16.0, // Increased font size for text under icons
            fontWeight: FontWeight.bold,
            color: Colors.indigoAccent,
          ),
        ),
      ],
    );
  }

  // Function to create doctors section with heading and grid
  Widget _buildDoctorsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Align the heading to the start
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0), // Padding for heading
          child: Text(
            "Satya Doctors", // Heading for doctors
            style: TextStyle(
              fontSize: 22, // Font size for heading
              fontWeight: FontWeight.bold,
              color: Colors.indigoAccent,
            ),
          ),
        ),
       // Space between heading and grid
        Expanded(
          child: _buildDoctorsGrid(), // Doctor grid
        ),
      ],
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
              // name: doctor['name']!,
              // specialty: doctor['specialty']!,
              // imagePath: doctor['imagePath']!,
            ),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 4.0, // Keep elevation for shadow effect
        child: Column(
          children: [
            // Doctor Image
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset(
                doctor['imagePath']!,
                height: 90, // Adjusted height for better visibility
                width: 80,  // Adjusted width for better visibility
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 2),
            // Doctor Name
            Flexible(
              child: Text(
                doctor['name']!,
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo[600],
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

  // Sample data for medical specialities
  final List<Map<String, String>> _specialities = [
    {
      'name': 'Gastro',
      'imagePath': 'assets/logos/stomach.png',
    },
    {
      'name': 'Dermats',
      'imagePath': 'assets/logos/skin.png',
    },
    {
      'name': 'Gynaecs',
      'imagePath': 'assets/logos/preggo.png',
    },
    {
      'name': 'Orthopedics',
      'imagePath': 'assets/logos/ray.png',
    },
    {
      'name': 'Pediatrics',
      'imagePath': 'assets/logos/babby.png',
    },
    {
      'name': 'Cardiologist',
      'imagePath': 'assets/logos/stomach.png',
    },
  ];

  // Sample data for doctors
  final List<Map<String, String>> _doctors = [
    {
      'name': 'Dr. Atish Mehta',
      'specialty': 'Ayurveda specialist',
      'imagePath': 'assets/onboarding/dr1.png',
    },
    {
      'name': 'Dr. Romal Jindal',
      'specialty': 'Pediatrician',
      'imagePath': 'assets/onboarding/dr2.png',
    },
    {
      'name': 'Dr. Aniket Shukla',
      'specialty': 'Skin specialist',
      'imagePath': 'assets/onboarding/dr3.png',
    },
  ];
}

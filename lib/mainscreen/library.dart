import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MedicineLibraryScreen extends StatelessWidget {
  // Launch URL in the in-app browser or default browser
  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medicine E-Library'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Book 1
              MedicineBookContainer(
                title: 'Pharmacology Handbook',
                author: 'Dr. Smith',
                imageUrl: 'assets/logos/pharmacology.png',
                bookUrl: 'https://pharma-book-example.com',
                onImageTap: () => _launchURL('https://pharma-book-example.com'),
              ),
              const SizedBox(height: 16.0),

              // Book 2
              MedicineBookContainer(
                title: 'Clinical Medicine Guide',
                author: 'Dr. Williams',
                imageUrl: 'assets/logos/clinical_medicine.png',
                bookUrl: 'https://clinical-guide-example.com',
                onImageTap: () => _launchURL('https://clinical-guide-example.com'),
              ),
              const SizedBox(height: 16.0),

              // Book 3
              MedicineBookContainer(
                title: 'Textbook of Pathology',
                author: 'Dr. Johnson',
                imageUrl: 'assets/logos/pathology.png',
                bookUrl: 'https://pathology-textbook-example.com',
                onImageTap: () => _launchURL('https://pathology-textbook-example.com'),
              ),
              const SizedBox(height: 16.0),

            ],
          ),
        ),
      ),
    );
  }
}

class MedicineBookContainer extends StatelessWidget {
  final String title;
  final String author;
  final String imageUrl;
  final String bookUrl;
  final VoidCallback onImageTap;

  const MedicineBookContainer({
    Key? key,
    required this.title,
    required this.author,
    required this.imageUrl,
    required this.bookUrl,
    required this.onImageTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onImageTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            // Book Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(15.0)),
              child: Image.asset(
                imageUrl,
                height: 150.0,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            // Book Information
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    'by $author',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

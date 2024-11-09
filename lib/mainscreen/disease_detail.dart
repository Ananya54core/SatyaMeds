import 'package:flutter/material.dart';

class DetailedResultScreen extends StatelessWidget {
  final Map<String, dynamic> diseaseData;
  final String diseaseName;

  const DetailedResultScreen({
    required this.diseaseData,
    required this.diseaseName,
  });

  Widget _buildSection(String title, List<dynamic> items, IconData icon) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.indigo[700], size: 24),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo[900],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...items.map((item) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.check_circle,
                  size: 20,
                  color: Colors.indigo[400],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diagnosis Results'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Colors.indigo.shade50,
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const SizedBox(height: 16), // Space where the image was
                  Text(
                    diseaseData['name'] ?? diseaseName,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo[900],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.indigo[100],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Severity: ${diseaseData['severity'] ?? "Unknown"}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.indigo,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.indigo[100],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Recovery Time: ${diseaseData['recovery_time'] ?? "N/A"}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.indigo,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _buildSection(
              'Common Symptoms',
              diseaseData['symptoms'] as List<dynamic>,
              Icons.sick_outlined,
            ),
            _buildSection(
              'Recommended Treatment',
              diseaseData['cure'] as List<dynamic>,
              Icons.healing_outlined,
            ),
            _buildSection(
              'Prevention',
              diseaseData['prevention'] as List<dynamic>,
              Icons.shield_outlined,
            ),
            _buildSection(
              'When to See a Doctor',
              diseaseData['when_to_see_doctor'] as List<dynamic>,
              Icons.local_hospital_outlined,
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

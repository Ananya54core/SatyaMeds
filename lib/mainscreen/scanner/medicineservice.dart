import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:satyameds/mainscreen/scanner/modalclass.dart';

class MedicineService {
  List<Medicine> _medicines = [];

  Future<void> loadMedicinesFromJson() async {
    try {
      // Load JSON data directly from assets
      final data = await rootBundle.loadString('assets/file/data_cbs.json');

      // Decode the JSON data
      List<dynamic> jsonData = json.decode(data);
      _medicines = jsonData.map((json) => Medicine.fromJson(json)).toList();

      // Print all loaded medicines for verification
      print('Loaded ${_medicines.length} medicines from JSON.');
      for (var medicine in _medicines) {
        print(medicine); // Ensure Medicine has a toString method for readable output
      }
    } catch (e) {
      print('Error loading medicines: $e');
    }
  }

  // Find a medicine by matching the label
  Medicine? findMedicineByLabel(String label) {
    try {
      // Trim and convert the input label to lowercase
      String trimmedLabel = label.trim().toLowerCase();
      print('Matching label: $trimmedLabel');

      for (Medicine medicine in _medicines) {
        // Trim and convert each medicine label to lowercase before comparing
        String medicineLabel = medicine.label.trim().toLowerCase();
        print('Checking label: $medicineLabel'); // Print each label being checked

        if (medicineLabel == trimmedLabel) {
          print('Match found for label: $trimmedLabel');
          return medicine;
        }
      }

      print('No medicine found for label: $trimmedLabel');
      return null;
    } catch (e) {
      print('Error finding medicine: $e');
      return null;
    }
  }

  // Get medicine details based on Edge Impulse label
  Future<Medicine?> getMedicineDetails(String label) async {
    if (_medicines.isEmpty) {
      await loadMedicinesFromJson();
    }
    return findMedicineByLabel(label);
  }
}

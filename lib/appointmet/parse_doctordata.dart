import 'dart:convert';
import 'doctor_modalclass.dart';

// Sample JSON data
String jsonData = '''
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
        },
        {
          "date": "2024-09-13",
          "time_slots": ["10:00", "11:30", "15:00"]
        }
      ]
    },
    {
      "id": 2,
      "name": "Dr. Sarah Smith",
      "speciality": "Dermatologist",
      "availability": [
        {
          "date": "2024-09-12",
          "time_slots": ["08:30", "09:30", "12:00", "14:00"]
        },
        {
          "date": "2024-09-14",
          "time_slots": ["09:00", "11:00", "13:30"]
        }
      ]
    }
  ]
}
''';

void parseDoctorsData() {
  Map<String, dynamic> data = jsonDecode(jsonData);
  List<dynamic> doctorsJson = data['doctors'];

  List<Doctor> doctors = doctorsJson.map((docJson) => Doctor.fromJson(docJson)).toList();

  // Example: Print all doctors and their availability
  for (var doctor in doctors) {
    print('Doctor: ${doctor.name}');
    for (var availability in doctor.availability) {
      print('Available on ${availability.date} at ${availability.timeSlots}');
    }
  }
}

// models/doctor_modalclass.dart
class Doctor {
  final int id;
  final String name;
  final String speciality;
  final List<Availability> availability;

  Doctor({
    required this.id,
    required this.name,
    required this.speciality,
    required this.availability,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'],
      name: json['name'],
      speciality: json['speciality'],
      availability: (json['availability'] as List)
          .map((item) => Availability.fromJson(item))
          .toList(),
    );
  }
}

class Availability {
  final String date;
  final List<String> timeSlots;

  Availability({required this.date, required this.timeSlots});

  factory Availability.fromJson(Map<String, dynamic> json) {
    return Availability(
      date: json['date'],
      timeSlots: List<String>.from(json['time_slots']),
    );
  }
}

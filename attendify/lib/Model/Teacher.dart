// models/teacher.dart
class Teacher {
  final int id;
  final String schoolId;
  final String firstName;
  final String lastName;
  final String email;

  Teacher({
    required this.id,
    required this.schoolId,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
      id: json['id'],
      schoolId: json['school_id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'school_id': schoolId,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
    };
  }
}

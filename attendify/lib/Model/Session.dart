
import 'package:attendify/Model/SessionParticipant.dart';
import 'package:attendify/Model/StudentModel.dart';

class Session {
  final int id;
  final int sectionId;
  final String date;
  final String startTime;
  final String? endTime;
  final List<StudentModel> students;

  Session({
    required this.id,
    required this.sectionId,
    required this.date,
    required this.startTime,
    this.endTime,
    required this.students,
  });

  // Factory constructor to create an instance from JSON
  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      id: json['id'],
      sectionId: json['section_id'],
      date: json['date'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      students: json['students'] != null
          ? (json['students'] as List<dynamic>)
          .map((studentJson) => StudentModel.fromJson(studentJson))
          .toList()
          : [], // Return an empty list if students is null or not a list
    );
  }


}
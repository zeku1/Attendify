import 'ClassSession.dart';
import 'Session.dart';

class Section {
  final int id;
  final String sectionName;
  final int teacherId;
  final String teacherName;
  final String year;
  final String semester;
  final List<Session> sessions;

  Section({
    required this.id,
    required this.sectionName,
    required this.teacherId,
    required this.teacherName,
    required this.year,
    required this.semester,
    required this.sessions,
  });

  factory Section.fromJson(Map<String, dynamic> json) {
    var classSessionsJson = json['class_sessions'] as List<dynamic>?; // Handle null safety if class_sessions is null
    List<Session> sessions = classSessionsJson != null
        ? classSessionsJson.map((sessionJson) => Session.fromJson(sessionJson)).toList()
        : [];

    return Section(
      id: json['id'],
      sectionName: json['section_name'],
      teacherId: json['teacher_id'],
      teacherName: json['teacher_name'],
      year: json['year'],
      semester: json['semester'],
      sessions: sessions, // Pass the list of sessions
    );
  }
}

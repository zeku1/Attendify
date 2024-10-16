
class SessionParticipant {
  final int id;
  final int classSessionId;
  final int studentId;
  final String time;

  SessionParticipant({
    required this.id,
    required this.classSessionId,
    required this.studentId,
    required this.time,
  });

  // Factory method to create a SessionParticipant from JSON
  factory SessionParticipant.fromJson(Map<String, dynamic> json) {
    return SessionParticipant(
      id: json['id'],
      classSessionId: json['class_session_id'],
      studentId: json['student_id'],
      time: json['time'],
    );
  }
}
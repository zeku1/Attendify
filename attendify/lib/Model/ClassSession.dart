class ClassSession {
  final int id;
  final String sessionName;
  final String startTime;
  final String endTime;

  ClassSession({
    required this.id,
    required this.sessionName,
    required this.startTime,
    required this.endTime,
  });

  factory ClassSession.fromJson(Map<String, dynamic> json) {
    return ClassSession(
      id: json['id'],
      sessionName: json['session_name'],
      startTime: json['start_time'],
      endTime: json['end_time'],
    );
  }
}

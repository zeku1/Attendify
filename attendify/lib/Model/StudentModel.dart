
import 'package:attendify/Model/Section.dart';

class StudentModel{
  final int id;
  final String schoolId;
  final String firstName;
  final String lastName;
  final String email;
  final bool isEnrolled;
  final String? imageLink;
  final List<Section> sections;

  StudentModel({
    required this.id,
    required this.schoolId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.isEnrolled,
    this.imageLink,
    required this.sections,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    List<Section> sections = [];

    // Check if 'sections' exists and is a List
    if (json['sections'] != null && json['sections'] is List) {
      var sectionList = json['sections'] as List;
      sections = sectionList.map((i) => Section.fromJson(i)).toList();
    }
    return StudentModel(
      id: json['id'],
      schoolId: json['school_id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      isEnrolled: json['isEnrolled'],
      imageLink: json['image_link'],
      sections: sections,
    );
  }
}
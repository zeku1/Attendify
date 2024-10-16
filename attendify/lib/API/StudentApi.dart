import 'dart:convert';
import 'package:attendify/Model/StudentModel.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class StudentApi {
  String? url;
  SharedPreferences? _prefs;
  String? token;

  // Constructor to initialize the API with the token
  StudentApi() {
    _initialize();
  }

  Future<void> _initialize() async {
    await dotenv.load(); // Ensure dotenv is loaded

    _prefs = await SharedPreferences.getInstance();
    token = _prefs?.getString('token');
    url = _prefs?.getString('url');
  }

  // Fetch student data by ID
  Future<StudentModel> getStudent(int? id) async {
    if (id == null) {
      throw Exception('Student ID is null');
    }

    final response = await http.get(
      Uri.parse('$url/student/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      return StudentModel.fromJson(responseBody['student']);
    } else if (response.statusCode == 404){
      throw Exception('not found');
    }else{
      throw Exception('Failed to fetch student');
    }
  }

  Future<List<StudentModel>> fetchStudents() async {
    if (token == null) {
      throw Exception('Token is null');
    }

    // Make the GET request
    final response = await http.get(
      Uri.parse('$url/student'), // Ensure this matches your backend route
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token', // Include the Bearer token for authentication
      },
    );

    // Handle the response
    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedResponse = jsonDecode(response.body);
      final List<dynamic> studentJsonList = decodedResponse['student']; // Adjust to the correct key
      final List<StudentModel> students = studentJsonList
          .map((studentJson) => StudentModel.fromJson(studentJson))
          .toList();
      return students; // Return the list of students
    } else if (response.statusCode == 403) {
      throw Exception('Unauthorized access. You are not a teacher.');
    } else {
      throw Exception('Failed to retrieve students: ${response.body}');
    }
  }


}

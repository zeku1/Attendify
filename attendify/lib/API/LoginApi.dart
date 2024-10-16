import 'dart:convert';
import 'package:attendify/Model/Teacher.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginApi {
  String? url;

  LoginApi() {
    url = dotenv.get('URL');
  }
  Future<String> login(String email, String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await http.post(
      Uri.parse('$url/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      String token = responseBody['token'];
      String role = responseBody['role'];

      if (role == 'student') {
        int studentId = responseBody['student']['id'];
        String schoolId = responseBody['student']['school_id'];

        Map<String, dynamic> student = responseBody['student'];
        await prefs.setString('student', jsonEncode(student));

        await prefs.setInt('student_id', studentId);
        await prefs.setString('school_id', schoolId);
      } else if (role == 'teacher') {
        int studentId = responseBody['teacher']['id'];
        String schoolId = responseBody['teacher']['school_id'];

        await prefs.setInt('teacher_id', studentId);
        await prefs.setString('school_id', schoolId);
      }

      await prefs.setString('token', token);
      await prefs.setString('role', role);

      print('Login successful! Token: $token');
      return 'Login successfully!';
    } else {
      throw Exception('Failed to login');
    }
  }

}
import 'dart:convert';
import 'dart:ffi';
import 'package:attendify/Model/Session.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SessionApi {
  String? url;
  SharedPreferences? _prefs;
  String? token;
  int? studentId;

  // Constructor to initialize the API with the token
  SessionApi() {
    _initialize();
  }

  Future<void> _initialize() async {
    // Ensure you have a valid URL from your .env file

    _prefs = await SharedPreferences.getInstance();
    token = _prefs?.getString('token');
    studentId = _prefs?.getInt('student_id');
    url = _prefs?.getString('url');
  }

  Future<String> joinSession(int sessionId, String time) async {
    // Ensure the token and studentId are initialized
    if (token == null || studentId == null) {
      throw Exception('Token or Student ID is not initialized');
    }

    final String apiUrl = '$url/session/join-session';

    try {
      final response = await http.post(
        Uri.parse(apiUrl), // Ensure this matches your backend route
        headers: <String, String>{
          "Accept" : "application/json",
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, dynamic>{
          'session_id': sessionId,
          'student_id': studentId,
          'time': time, // Format should be H:i:s
        }),
      );

      print(response.statusCode);
      print(response.body);
      // Handle the response
      if (response.statusCode == 201 || response.statusCode == 200) {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        return responseBody['message'] ?? 'Session joined successfully';
      } else if (response.statusCode == 400) {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        throw Exception(responseBody['error_message'] ?? 'Failed to join session');
      } else if (response.statusCode == 422) {
        throw Exception('The session has already ended.');
      } else {
        throw Exception('Unexpected error occurred. Please try again.');
      }
    } catch (e) {
      throw Exception('Error connecting to the server: $e');
    }
  }

  Future<Session> getClassSession(int sessionId) async {
    final String apiUrl = '$url/session/$sessionId';

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      try {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        return Session.fromJson(responseBody['session']);
      } catch (e) {
        // Handle JSON decode error
        print(response.body);
        print('Error decoding JSON: $e');
        throw Exception('Failed to decode session data');
      }
    } else {
      // Print the full response for debugging
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      try {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        throw Exception(responseBody['message'] ?? 'Failed to end session');
      } catch (e) {
        // If the response isn't valid JSON, handle it here
        throw Exception('Unexpected response format: ${response.body}');
      }
    }
  }


  Future<Session?> startSession(int sectionId) async {

    final String apiUrl = '$url/session/open-session/$sectionId';

    // Create the request body
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    // Check if the response is successful
    if (response.statusCode == 201) {
      // Success, parse the JSON into a ClassSession object
      final responseData = json.decode(response.body);
      print(apiUrl);
      return Session.fromJson(responseData['session']);
    } else {
      // Error handling
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      throw Exception(responseBody['error_message'] ?? 'Failed to end session');
    }
  }

  Future<Session> endClassSession(int sectionId) async {
    // Ensure the token is initialized
    if (token == null) {
      throw Exception('Token is not initialized');
    }

    // Send a POST request to end the session
    final response = await http.post(
      Uri.parse('$url/session/end-session'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, dynamic>{
        'section_id': sectionId,
      }),
    );

    // Handle the response
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      return Session.fromJson(responseBody['session']);
    } else {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      throw Exception(responseBody['error_message'] ?? 'Failed to end session');
    }
  }

  Future<String> addStudentToSession(int sessionId, String studentSchoolId, String time) async {
    final urlApi = '$url/session/add-student';

    // Make the POST request
    final response = await http.post(
      Uri.parse(urlApi),
      headers: <String, String>{
        "Accept": "application/json",
        "Content-Type": "application/json", // Ensure correct content type
        'Authorization': 'Bearer $token', // Include token if required
      },
      body: jsonEncode(<String, dynamic>{
        'id': sessionId,
        'student_school_id': studentSchoolId,
        'time': time, // Expected format: 'H:i:s'
      }),
    );

    // Log the status code and body for debugging
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    print(token);

    // Check the response status
    if (response.statusCode == 201) {
      // Successfully recorded attendance
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      return responseBody['message']; // Success message
    } else {
      // Handle error response
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      throw Exception(responseBody['message'] ?? 'Failed to record attendance');
    }
  }



}

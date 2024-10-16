import 'dart:convert';
import 'package:attendify/Model/Section.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ClassApi {

  String? _url;
  SharedPreferences? _prefs;
  String? _token;

  // Constructor to initialize the API with the token
  ClassApi() {
    _initialize();
  }

  Future<void> _initialize() async {
    await dotenv.load(); // Ensure dotenv is loaded
    _url = dotenv.get('URL');
    _prefs = await SharedPreferences.getInstance();
    _token = _prefs?.getString('token');
  }

  Future<List<Section>> getSectionsByTeacherId(int teacherId) async {

    final url = '$_url/class/$teacherId';

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $_token', // Add your token if needed
      },
    );

    // Debugging information
    print('Response status: ${response.statusCode}');
    print('Response headers: ${response.headers}');
    print('Response body: ${response.body}');

    // Handle the response
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      // Map the classes to a List<Section> object
      List<Section> sections = (responseBody['classes'] as List)
          .map((section) => Section.fromJson(section))
          .toList();
      return sections; // Return the list of sections
    } else if (response.statusCode == 404) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      print('Error: ${responseBody['message']}');
      return []; // Return an empty list if no data found
    } else {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      throw Exception('Error: ${responseBody['message']}'); // Handle other errors
    }
  }

  Future<Section> createSection(String sectionName, int teacherId, String semester) async {
    if (_token == null) {
      throw Exception('Token is not initialized');
    }

    final url = '$_url/class/create';

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $_token',
      },
      body: jsonEncode({
        'section_name': sectionName,
        'teacher_id': teacherId,
        'semester': semester,
      }),
    );

    if (response.statusCode == 201) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      Section createdSection = Section.fromJson(responseBody['section']);
      print('success creating');
      return createdSection;
    } else {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      throw Exception('Error: ${responseBody['message']}');
    }
  }

  Future<Section> getSection(int id) async {
    if (_token == null) {
      throw Exception('Token is not initialized');
    }
    final url = '$_url/class/$id';

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $_token',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      print(responseBody['message']);

      Section section = Section.fromJson(responseBody['class']);
      return section;
    } else {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      throw Exception('Error: ${responseBody['message']}');
    }
  }

  Future<void> addStudents( int classId, List<int> studentIds) async {
    // Define the API endpoint
    final apiUrl = Uri.parse('$_url/class/add-students'); // Adjust the URL to match your backend route

    // Make the POST request
    final response = await http.post(
      apiUrl,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_token', // Add the Bearer token for authentication
      },
      body: jsonEncode({
        'class_id': classId,
        'student_ids': studentIds,
      }),
    );

    // Handle the response
    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      print('Success: ${responseBody['message']}');
    } else {
      print('Error: ${response.statusCode} - ${response.body}');
      throw Exception('Failed to add students');
    }
  }

  Future<void> deleteSection(int id) async {
    if (_token == null) {
      throw Exception('Token is not initialized');
    }

    final url = '$_url/class/destroy/$id'; // Construct the URL

    final response = await http.delete(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $_token',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      print(responseBody['message']); // Successfully deleted message
    } else {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      throw Exception('Error: ${responseBody['message']}'); // Handle error
    }
  }
}

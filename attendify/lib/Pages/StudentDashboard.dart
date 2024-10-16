import 'package:attendify/API/StudentApi.dart';
import 'package:attendify/Components/GenerateQr.dart';
import 'package:attendify/Components/ProfileComponent.dart';
import 'package:attendify/Components/ScannerComponent.dart';
import 'package:attendify/Model/StudentModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Routes/AppRoutes.dart';

class ScannerPage extends StatefulWidget {
  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  SharedPreferences? _prefs;
  StudentModel? student;
  final StudentApi _studentApi = StudentApi();
  bool _isCreateRoomVisible = false;

  String? _role;
  String? _schoolId;
  int? _id;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeSharedPreferences();
  }

  // Initialize SharedPreferences and set state once loaded
  void _initializeSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _role = _prefs?.getString('role');
      _schoolId = _prefs?.getString('school_id');
      _id = _prefs?.getInt('student_id');
      _isLoading = false;

      // Fetch student data
      _getStudent();
    });

    if(_role == null){
      Navigator.pushNamed(context, AppRoutes.login);
    }
  }

  // Fetch student details from API
  void _getStudent() async {
    if (_id != null) {
      try {
        final fetchedStudent = await _studentApi.getStudent(_id);
        setState(() {
          student = fetchedStudent;
        });
      } catch (e) {
        print('Error fetching student: $e');

        // Reinitialize the state if the student is null
        setState(() {
          student = null; // Set to null, optional
          _isLoading = true;
        });

        // Call _initializeSharedPreferences to reset state
        _initializeSharedPreferences();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ATTENDIFY',
                  style: GoogleFonts.hankenGrotesk(
                    fontWeight: FontWeight.w900,
                    fontSize: 15,
                    color: Color(0x80000000), // 50% opacity black
                    height: 19.54 / 15,
                  ),
                ),
                Text(
                  student != null ? (student!.schoolId ?? '') : (_schoolId ?? ''),
                  style: GoogleFonts.hankenGrotesk(
                    fontWeight: FontWeight.w300,
                    fontSize: 15,
                    color: Color(0x80000000), // 50% opacity black
                    height: 19.54 / 15,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Handle sign-in action
                  },
                  child: Text(
                    (_role?.toUpperCase() ?? 'Sign in'),
                    style: GoogleFonts.hankenGrotesk(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      color: Color(0x91000000), // 57% opacity black
                      height: 19.54 / 15,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 50),
            Expanded(
              child: _isCreateRoomVisible
                  ? ScannerComponent()
                  : (student != null
                  ? ProfileComponent(student: student)
                  : Center(child: Text("No student data available."))),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0, left: 18),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isCreateRoomVisible = true; // Show CreateRoomComponent
                              });
                            },
                            child: Text(
                              'SCAN,',
                              style: GoogleFonts.hankenGrotesk(
                                fontWeight: FontWeight.w900,
                                fontSize: 23,
                                color: _isCreateRoomVisible
                                    ? const Color(0xff000000) // Highlight when active
                                    : const Color(0xff000000).withOpacity(0.5),
                                height: 32.57 / 25,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isCreateRoomVisible = false; // Show ViewRoomsComponent
                              });
                            },
                            child: Text(
                              'PROFILE',
                              style: GoogleFonts.hankenGrotesk(
                                fontWeight: FontWeight.w900,
                                fontSize: 23,
                                color: !_isCreateRoomVisible
                                    ? const Color(0xff000000) // Highlight when active
                                    : const Color(0xff000000).withOpacity(0.5),
                                height: 32.57 / 25,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

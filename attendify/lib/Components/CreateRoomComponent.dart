import 'package:attendify/API/StudentApi.dart';
import 'package:attendify/Model/StudentModel.dart';
import 'package:attendify/Pages/ClassDetailsPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:attendify/API/ClassApi.dart'; // Ensure you import the ClassApi
import 'package:attendify/Model/Section.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Routes/AppRoutes.dart'; // Ensure you import the Section model

class CreateRoomComponent extends StatefulWidget {
  final int? id;

  const CreateRoomComponent({super.key, this.id});

  @override
  _CreateRoomComponentState createState() => _CreateRoomComponentState();
}

class _CreateRoomComponentState extends State<CreateRoomComponent> {

  SharedPreferences? _prefs;

  String? _role;
  String? _schoolId;
  int? _id;
  bool _isLoading = true;

  bool _isCreateRoomVisible = true;

  final TextEditingController _semesterController = TextEditingController();
  final TextEditingController _classNameController = TextEditingController();

  bool _isSemesterFieldFocused = false;
  bool _isClassNameFieldFocused = false;

  List<StudentModel>? students;

  List<int> selectedStudentIds = [];


  final ClassApi _classApi = ClassApi();
  final StudentApi _studentApi = StudentApi();

  @override
  void initState() {

    super.initState();
    _initializeSharedPreferences();

  }

  void _initializeSharedPreferences() async {
    await dotenv.load(fileName: ".env");
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _role = _prefs?.getString('role');
      _schoolId = _prefs?.getString('school_id');
      _id = _prefs?.getInt('teacher_id');
      _isLoading = false;
    });

    if (_role == null || _id == null) {
      Navigator.pushNamed(context, AppRoutes.login);
    } else {
      _getStudents(); // Call to fetch students after initializing preferences
    }
  }

  void _getStudents() async {
    if (_id != null) {
      try {
        final fetchedStudents = await _studentApi.fetchStudents();
        setState(() {
          students = fetchedStudents;
        });
        print('Students fetched: $students');

        // Reinitialize if no students were fetched
        if (students == null || students!.isEmpty) {
          print('No students found, re-fetching...');
          _getStudents(); // Re-fetch students
        }
      } catch (error) {
        print('Error fetching students: $error');
        // Retry fetching students on error
        _initializeSharedPreferences();
      }
    }
  }

  @override
  void dispose() {
    _semesterController.dispose();
    _classNameController.dispose();
    super.dispose();
  }

  void _createSection() async {
    final sectionName = _classNameController.text.trim();
    final semester = _semesterController.text.trim();

    if (sectionName.isEmpty || semester.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields.')),
      );
      return;
    }

    if (selectedStudentIds.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please add students to the class.')),
      );
      return;
    }

    try {
      // Assuming `widget.id` is the teacherId
      Section createdSection = await _classApi.createSection(sectionName, widget.id!, semester);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Section "${createdSection.sectionName}" created successfully!')),
      );

      await _classApi.addStudents(createdSection.id, selectedStudentIds);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ClassDetailsPage(section: createdSection),
        ),
      );

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to create section: ${e.toString()}')),
      );
    }
  }

  void _onStudentSelected(bool? selected, int studentId) {
    setState(() {
      if (selected == true) {
        selectedStudentIds.add(studentId);
      } else {
        selectedStudentIds.remove(studentId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
          Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: _isCreateRoomVisible ? _createRoom() : _addStudent(), // Toggle between two views
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
                                      _isCreateRoomVisible = true;
                                    });
                                  },
                                  child: Text(
                                    'ROOM,',
                                    style: GoogleFonts.hankenGrotesk(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 23,
                                      color: _isCreateRoomVisible
                                          ? const Color(0xff000000)
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
                                    'ADD STUDENTS',
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
              )
          )
      ],
    );
  }

  Container _addStudent() {
    return Container(
      child: Column(
        children: [
          Center(
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Check ',
                    style: GoogleFonts.hankenGrotesk(
                      fontWeight: FontWeight.w400,
                      fontSize: 26,
                      color: const Color(0xff000000), // Solid black
                    ),
                  ),
                  TextSpan(
                    text: 'Student to ',
                    style: GoogleFonts.hankenGrotesk(
                      fontWeight: FontWeight.w400,
                      fontSize: 26,
                      color: const Color(0xff000000).withOpacity(
                          0.3), // Low opacity black
                    ),
                  ),
                  TextSpan(
                    text: 'Add',
                    style: GoogleFonts.hankenGrotesk(
                      fontWeight: FontWeight.w400,
                      fontSize: 26,
                      color: const Color(0xff000000), // Solid black
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: students != null && students!
                .isNotEmpty // Check if students is not null and not empty
                ? ListView(
              children: students!.map((student) {
                return CheckboxListTile(
                  title: Text(
                    student.firstName + ' ' + student.lastName,
                    style: GoogleFonts.hankenGrotesk(
                      textStyle: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  ),
                  value: selectedStudentIds.contains(student.id),
                  onChanged: (selected) {
                    _onStudentSelected(selected, student.id);
                  },
                );
              }).toList(),
            )
                : Center(child: Text(
                'No students available')), // Fallback when students is null or empty
          ),
        ],
      ),
    );
  }
  Container _createRoom(){
    return Container(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 150),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    if (!_isClassNameFieldFocused && _classNameController.text.isEmpty)
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Write ',
                              style: GoogleFonts.hankenGrotesk(
                                fontWeight: FontWeight.w300,
                                fontSize: 25,
                                color: Colors.black.withOpacity(0.5),
                              ),
                            ),
                            TextSpan(
                              text: 'class name',
                              style: GoogleFonts.hankenGrotesk(
                                fontWeight: FontWeight.w300,
                                fontSize: 25,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: ' here',
                              style: GoogleFonts.hankenGrotesk(
                                fontWeight: FontWeight.w300,
                                fontSize: 25,
                                color: Colors.black.withOpacity(0.5),
                              ),
                            ),
                          ],
                        ),
                      ),
                    Focus(
                      onFocusChange: (hasFocus) {
                        setState(() {
                          _isClassNameFieldFocused = hasFocus;
                        });
                      },
                      child: TextField(
                        controller: _classNameController,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.hankenGrotesk(
                          fontWeight: FontWeight.w400,
                          fontSize: 25,
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '',
                        ),
                        onChanged: (text) {
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Semester Input Field
          Container(
            margin: const EdgeInsets.only(top: 1),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    if (!_isSemesterFieldFocused && _semesterController.text.isEmpty)
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Write ',
                              style: GoogleFonts.hankenGrotesk(
                                fontWeight: FontWeight.w300,
                                fontSize: 25,
                                color: Colors.black.withOpacity(0.5),
                              ),
                            ),
                            TextSpan(
                              text: 'semester',
                              style: GoogleFonts.hankenGrotesk(
                                fontWeight: FontWeight.w300,
                                fontSize: 25,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: ' here',
                              style: GoogleFonts.hankenGrotesk(
                                fontWeight: FontWeight.w300,
                                fontSize: 25,
                                color: Colors.black.withOpacity(0.5),
                              ),
                            ),
                          ],
                        ),
                      ),
                    Focus(
                      onFocusChange: (hasFocus) {
                        setState(() {
                          _isSemesterFieldFocused = hasFocus;
                        });
                      },
                      child: TextField(
                        controller: _semesterController,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.hankenGrotesk(
                          fontWeight: FontWeight.w400,
                          fontSize: 25,
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '',
                        ),
                        onChanged: (text) {
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 40),
                  child: Center(
                    child: GestureDetector(
                      onTap: _createSection, // Call the create section method
                      child: Text(
                        'BUILD ROOM',
                        style: GoogleFonts.hankenGrotesk(
                          fontWeight: FontWeight.w900,
                          fontSize: 25,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

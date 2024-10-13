import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'AddStudentsComponent.dart';

class CreateRoomComponent extends StatefulWidget {
  @override
  _CreateRoomComponentState createState() => _CreateRoomComponentState();
}

class _CreateRoomComponentState extends State<CreateRoomComponent> {
  final TextEditingController _semesterController = TextEditingController();
  final TextEditingController _classNameController = TextEditingController();
  bool _isSemesterFieldFocused = false;
  bool _isClassNameFieldFocused = false;
  bool _showAddStudents = false; // Toggle between components

  @override
  void dispose() {
    _semesterController.dispose();
    _classNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            if (_showAddStudents)
              Expanded(
                child:
                    AddStudentsPage(), // Show AddStudentsComponent when _showAddStudents is true
              )
            else
              Expanded(
                child: Column(
                  children: [
                    // Class Name Input Field
                    Container(
                      margin: const EdgeInsets.only(top: 150),
                      child: Column(
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              if (!_isClassNameFieldFocused &&
                                  _classNameController.text.isEmpty)
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
                              if (!_isSemesterFieldFocused &&
                                  _semesterController.text.isEmpty)
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
                        ],
                      ),
                    ),
                    // Build Room Button
                    Container(
                      margin: const EdgeInsets.only(top: 40),
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            // Action when Build Room is pressed
                          },
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

            // Bottom Buttons (ROOM, ADD STUDENTS)
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _showAddStudents = false; // Show CreateRoomComponent
                        });
                      },
                      child: Text(
                        'ROOM,',
                        style: GoogleFonts.hankenGrotesk(
                          fontWeight: FontWeight.w900,
                          fontSize: 23,
                          color: _showAddStudents
                              ? Colors.black.withOpacity(0.5)
                              : Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _showAddStudents = true; // Show AddStudentsComponent
                        });
                      },
                      child: Text(
                        'ADD STUDENTS',
                        style: GoogleFonts.hankenGrotesk(
                          fontWeight: FontWeight.w900,
                          fontSize: 23,
                          color: _showAddStudents
                              ? Colors.black
                              : Colors.black.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20), // Add spacing from the bottom
              ],
            ),
          ],
        ),
      ),
    );
  }
}

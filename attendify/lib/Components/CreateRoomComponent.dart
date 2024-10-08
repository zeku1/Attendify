import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateRoomComponent extends StatefulWidget {
  @override
  _CreateRoomComponentState createState() => _CreateRoomComponentState();
}

class _CreateRoomComponentState extends State<CreateRoomComponent> {
  // Added missing controllers and focus tracking variables
  final TextEditingController _semesterController = TextEditingController();
  final TextEditingController _classNameController = TextEditingController(); // Added
  bool _isSemesterFieldFocused = false;
  bool _isClassNameFieldFocused = false; // Added

  @override
  void dispose() {
    _semesterController.dispose();
    _classNameController.dispose(); // Dispose of the class name controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Class Name Input Field
        Container(
          margin: const EdgeInsets.only(top: 150),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  // Show the placeholder text when the field is unfocused and empty
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
                        hintText: '', // Empty hint because we handle the placeholder manually
                      ),
                      onChanged: (text) {
                        setState(() {}); // Trigger rebuild to hide/show placeholder
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
                  // Show the placeholder text when the field is unfocused and empty
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
                      obscureText: false, // Semester should not be obscure
                      style: GoogleFonts.hankenGrotesk(
                        fontWeight: FontWeight.w400,
                        fontSize: 25,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '', // Empty hint because we handle the placeholder manually
                      ),
                      onChanged: (text) {
                        setState(() {}); // Trigger rebuild to hide/show placeholder
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
            // Center the text button
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
    );
  }
}

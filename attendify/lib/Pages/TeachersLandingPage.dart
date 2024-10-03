import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:attendify/Routes/AppRoutes.dart'; // Make sure the path is correct

class TeachersLandingPage extends StatefulWidget {
  @override
  _TeachersLandingPageState createState() => _TeachersLandingPageState();
}

class _TeachersLandingPageState extends State<TeachersLandingPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isEmailFieldFocused = false;
  bool _isPasswordFieldFocused = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ATTENDIFY and SIGN IN at the top
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.SignIn);
                  },
                  child: Text(
                    'ATTENDIFY',
                    style: GoogleFonts.hankenGrotesk(
                      fontWeight: FontWeight.w900,
                      fontSize: 15,
                      color: Color(0x80000000), // 50% opacity black
                      height: 19.54 / 15,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Handle sign-in action
                  },
                  child: Text(
                    'TEACHER',
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

            // "CREATE ROOM, VIEW ROOMS" section now placed below ATTENDIFY and TEACHER
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left:18 ), // Add space from the top
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Action for "CREATE ROOM"
                    },
                    child: Text(
                      'CREATE ROOM,',
                      style: GoogleFonts.hankenGrotesk(
                        fontWeight: FontWeight.w900,
                        fontSize: 23,
                        color: Color(0xff000000),
                        height: 32.57 / 25,
                      ),
                    ),
                  ),
                  SizedBox(width: 8), // Add some spacing between the two texts
                  GestureDetector(
                    onTap: () {
                      // Action for "VIEW ROOMS"
                    },
                    child: Text(
                      'VIEW ROOMS',
                      style: GoogleFonts.hankenGrotesk(
                        fontWeight: FontWeight.w900,
                        fontSize: 23,
                        color: Color(0xff000000).withOpacity(0.5), // 50% opacity for VIEW ROOMS
                        height: 32.57 / 25,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Center section for email and password input
            Spacer(flex: 1), // Adds flexible space between the sections

            Center(
              child: Column(
                children: [
                  // Stack for the email field
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      // Show hint when the field is not focused and empty
                      if (!_isEmailFieldFocused && _emailController.text.isEmpty)
                        RichText(
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
                      // Email input
                      Focus(
                        onFocusChange: (hasFocus) {
                          setState(() {
                            _isEmailFieldFocused = hasFocus;
                          });
                        },
                        child: TextField(
                          controller: _emailController,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.hankenGrotesk(
                            fontWeight: FontWeight.w400,
                            fontSize: 25,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '', // Removing the default hintText
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Stack for the password field
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      // Show hint when the field is not focused and empty
                      if (!_isPasswordFieldFocused && _passwordController.text.isEmpty)
                        RichText(
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
                      // Password input
                      Focus(
                        onFocusChange: (hasFocus) {
                          setState(() {
                            _isPasswordFieldFocused = hasFocus;
                          });
                        },
                        child: TextField(
                          controller: _passwordController,
                          textAlign: TextAlign.center,
                          obscureText: true,
                          style: GoogleFonts.hankenGrotesk(
                            fontWeight: FontWeight.w400,
                            fontSize: 25,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '', // Removing the default hintText
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 60), // Space between password and "BUILD ROOM"

                  GestureDetector(
                    onTap: () {
                      // Handle "BUILD ROOM" action
                    },
                    child: Text(
                      'BUILD ROOM',
                      style: GoogleFonts.hankenGrotesk(
                        fontWeight: FontWeight.w900,
                        fontSize: 25,
                        color: Color(0xff000000),
                        height: 32.57 / 25,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Spacer(flex: 2), // Adds flexible space at the bottom
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:attendify/Routes/AppRoutes.dart';
import 'package:attendify/Components/AppBarComponent.dart';
import 'package:attendify/Pages/TeachersDashboardPage.dart'; // Import AppBarComponent

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
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
      appBar: AppBarComponent(), // Use AppBarComponent
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(flex: 20), // Add some spacing
            Center(
              child: Column(
                children: [
                  // Email input field
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
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
                                  text: 'email',
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
                              hintText: '',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.only(top: 1),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
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
                                  text: 'password',
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
                              hintText: '',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: GestureDetector(
                      onTap: () {
                        // Handle forgot password action
                      },
                      child: Text(
                        'Forgot password?',
                        style: GoogleFonts.hankenGrotesk(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.only(top: 40),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.teachersDashboard);
                      },
                      child: Text(
                        'JUMP IN',
                        style: GoogleFonts.hankenGrotesk(
                          fontWeight: FontWeight.w900,
                          fontSize: 25,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.only(top: 280),
                    child: GestureDetector(
                      onTap: () {
                        // Handle action for "Don't have an account yet?"
                      },
                      child: Text(
                        'Don\'t have an account yet?',
                        style: GoogleFonts.hankenGrotesk(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(flex: 2), // Bottom space
          ],
        ),
      ),
    );
  }
}

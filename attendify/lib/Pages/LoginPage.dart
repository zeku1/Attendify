import 'package:attendify/API/LoginApi.dart';
import 'package:attendify/Routes/AppRoutes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  SharedPreferences? _prefs;

  final email = TextEditingController();
  final password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final LoginApi _loginApi = LoginApi();

  bool _isEmailFieldFocused = false;
  bool _isPasswordFieldFocused = false;

  @override
  void initState() {

    super.initState();
    _initializeSharedPreferences();
  }

  void _initializeSharedPreferences() async {
    await dotenv.load(fileName: ".env");
    _prefs = await SharedPreferences.getInstance(); // Initialize once
  }

  String? _getRole() {
    return _prefs?.getString('role');
  }

  int? _getStudentId() {
    return _prefs?.getInt('student_id');
  }

  int? _getTeacherId() {
    return _prefs?.getInt('teacher_id');
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      try {
        String result = await _loginApi.login(
          email.text.trim(),
          password.text.trim(),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result)),
        );

        if (_getRole() == 'student') {
          Navigator.pushNamed(context, AppRoutes.studentDashboard);
        } else if (_getRole() == 'teacher') {
          Navigator.pushNamed(context, AppRoutes.teachersDashboard);
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: ${e.toString()}')),
        );
      }
    }
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
                Text(
                  'ATTENDIFY',
                  style: GoogleFonts.hankenGrotesk(
                    fontWeight: FontWeight.w900,
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
                    'SIGN IN',
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
            // Spacing between top and center content
            Container(margin: EdgeInsets.only(bottom: 280)),

            // Form wrapped around the fields
            Form(
              key: _formKey,
              child: Center(
                child: Column(
                  children: [
                    // Stack for the email field
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        if (!_isEmailFieldFocused && email.text.isEmpty)
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
                        // Email input
                        Focus(
                          onFocusChange: (hasFocus) {
                            setState(() {
                              _isEmailFieldFocused = hasFocus;
                            });
                          },
                          child: TextFormField(
                            controller: email,
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter an email';
                              }
                              if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),

                    // Space between email and password
                    Container(margin: EdgeInsets.only(bottom: 20)),

                    // Stack for the password field
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        if (!_isPasswordFieldFocused && password.text.isEmpty)
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
                        // Password input
                        Focus(
                          onFocusChange: (hasFocus) {
                            setState(() {
                              _isPasswordFieldFocused = hasFocus;
                            });
                          },
                          child: TextFormField(
                            controller: password,
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              if (value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),

                    // Space between password and Forgot Password
                    Container(margin: EdgeInsets.only(bottom: 20)),

                    GestureDetector(
                      onTap: () {
                        // Handle forgot password
                      },
                      child: Text(
                        'Forgot password?',
                        style: GoogleFonts.hankenGrotesk(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Color(0xff000000).withOpacity(0.5),
                          height: 15.64 / 12,
                        ),
                      ),
                    ),

                    // Space between Forgot Password and JUMP IN
                    Container(margin: EdgeInsets.only(bottom: 60)),

                    GestureDetector(
                      onTap: _login,
                      child: Text(
                        'JUMP IN',
                        style: GoogleFonts.hankenGrotesk(
                          fontWeight: FontWeight.w900,
                          fontSize: 25,
                          color: Color(0xff000000),
                          height: 32.57 / 25,
                        ),
                      ),
                    ),

                    // Space between JUMP IN and bottom text
                    Container(margin: EdgeInsets.only(bottom: 175)),

                    GestureDetector(
                      onTap: () {
                        // Handle "Don't have an account yet?" action
                      },
                      child: Text(
                        'Don\'t have an account yet?',
                        style: GoogleFonts.hankenGrotesk(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Color(0xff000000).withOpacity(0.5),
                          height: 15.64 / 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Spacer(flex: 2), // Bottom space
          ],
        ),
      ),
    );
  }
}

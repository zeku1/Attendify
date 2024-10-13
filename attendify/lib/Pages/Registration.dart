import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:attendify/Components/AppBarComponent.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _idNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _isFirstNameFocused = false;
  bool _isLastNameFocused = false;
  bool _isEmailFocused = false;
  bool _isIdNumberFocused = false;
  bool _isPasswordFocused = false;
  bool _isConfirmPasswordFocused = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _idNumberController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Widget buildTextField({
    required String hint,
    required String label,
    required TextEditingController controller,
    required bool isFocused,
    required Function(bool) onFocusChange,
    bool obscureText = false,
    EdgeInsetsGeometry? margin,
  }) {
    return Container(
      margin: margin ?? const EdgeInsets.only(top: 10), // You can pass custom margins
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (!isFocused && controller.text.isEmpty)
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
                    text: label,
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
            onFocusChange: (hasFocus) => onFocusChange(hasFocus),
            child: TextField(
              controller: controller,
              textAlign: TextAlign.center,
              obscureText: obscureText,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBarComponent(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 2),
            Center(
              child: Column(
                children: [
                  // First Name input field
                  buildTextField(
                    hint: 'Write first name here',
                    label: 'first name',
                    controller: _firstNameController,
                    isFocused: _isFirstNameFocused,
                    onFocusChange: (hasFocus) {
                      setState(() {
                        _isFirstNameFocused = hasFocus;
                      });
                    },
                    margin: const EdgeInsets.only(top: 20),
                  ),
                  // Last Name input field
                  buildTextField(
                    hint: 'Write last name here',
                    label: 'last name',
                    controller: _lastNameController,
                    isFocused: _isLastNameFocused,
                    onFocusChange: (hasFocus) {
                      setState(() {
                        _isLastNameFocused = hasFocus;
                      });
                    },
                    margin: const EdgeInsets.only(top: 20),
                  ),
                  // Email input field
                  buildTextField(
                    hint: 'Write email here',
                    label: 'email',
                    controller: _emailController,
                    isFocused: _isEmailFocused,
                    onFocusChange: (hasFocus) {
                      setState(() {
                        _isEmailFocused = hasFocus;
                      });
                    },
                    margin: const EdgeInsets.only(top: 20),
                  ),
                  // ID Number input field
                  buildTextField(
                    hint: 'Write id number here',
                    label: 'id number',
                    controller: _idNumberController,
                    isFocused: _isIdNumberFocused,
                    onFocusChange: (hasFocus) {
                      setState(() {
                        _isIdNumberFocused = hasFocus;
                      });
                    },
                    margin: const EdgeInsets.only(top: 20),
                  ),
                  // Password input field
                  buildTextField(
                    hint: 'Write password here',
                    label: 'password',
                    controller: _passwordController,
                    isFocused: _isPasswordFocused,
                    onFocusChange: (hasFocus) {
                      setState(() {
                        _isPasswordFocused = hasFocus;
                      });
                    },
                    obscureText: true,
                    margin: const EdgeInsets.only(top: 20),
                  ),
                  // Confirm Password input field
                  buildTextField(
                    hint: 'Rewrite password here',
                    label: 'password',
                    controller: _confirmPasswordController,
                    isFocused: _isConfirmPasswordFocused,
                    onFocusChange: (hasFocus) {
                      setState(() {
                        _isConfirmPasswordFocused = hasFocus;
                      });
                    },
                    obscureText: true,
                    margin: const EdgeInsets.only(top: 20),
                  ),
                  // Create button
                  GestureDetector(
                    onTap: () {
                      // Add your onTap logic here
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: Text(
                        'CREATE',
                        style: GoogleFonts.hankenGrotesk(
                          fontWeight: FontWeight.w900,
                          fontSize: 25,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(flex: 300),
          ],
        ),
      ),
    );
  }
}

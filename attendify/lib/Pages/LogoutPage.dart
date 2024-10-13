import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:attendify/Components/AppBarComponent.dart';

class LogoutPage extends StatefulWidget {
  @override
  _LogoutPageState createState() => _LogoutPageState();
}

class _LogoutPageState extends State<LogoutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBarComponent(), // Custom AppBar
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // "Do you want to log out?" Text
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Do you want to ',
                    style: GoogleFonts.hankenGrotesk(
                      fontWeight: FontWeight.w300,
                      fontSize: 25,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                  TextSpan(
                    text: 'log out?',
                    style: GoogleFonts.hankenGrotesk(
                      fontWeight: FontWeight.w600,
                      fontSize: 25,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20), // Space between text and buttons
            
            // YES and NO Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    // Handle "YES" tap
                    print("YES tapped");
                  },
                  child: Text(
                    'YES',
                    style: GoogleFonts.hankenGrotesk(
                      fontWeight: FontWeight.w900,
                      fontSize: 30,
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ),
                ),
                const SizedBox(width: 30), // Space between YES and NO
                GestureDetector(
                  onTap: () {
                    // Handle "NO" tap
                    print("NO tapped");
                  },
                  child: Text(
                    'NO',
                    style: GoogleFonts.hankenGrotesk(
                      fontWeight: FontWeight.w900,
                      fontSize: 30,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

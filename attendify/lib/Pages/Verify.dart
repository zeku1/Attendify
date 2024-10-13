import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:attendify/Components/AppBarComponent.dart';

class Verify extends StatefulWidget {
  @override
  _VerifyState createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  bool _isViewRoomsVisible = true; // Start with grid view by default

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBarComponent(), // Custom AppBar
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 1.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between top and bottom
          children: [
            // Main content text block
            Column(
              children: [
                // "You're a step closer!"
                Container(
                  margin: const EdgeInsets.only(top: 200), // Replaces SizedBox for spacing
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'You\'re a ',
                          style: GoogleFonts.hankenGrotesk(
                            fontWeight: FontWeight.w300,
                            fontSize: 25,
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                        TextSpan(
                          text: 'step closer!',
                          style: GoogleFonts.hankenGrotesk(
                            fontWeight: FontWeight.w600,
                            fontSize: 25,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                // Space using margin between texts
                Container(
                  margin: const EdgeInsets.only(top: 20), // Adds space instead of SizedBox
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'A ',
                          style: GoogleFonts.hankenGrotesk(
                            fontWeight: FontWeight.w300,
                            fontSize: 25,
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                        TextSpan(
                          text: 'verification email',
                          style: GoogleFonts.hankenGrotesk(
                            fontWeight: FontWeight.w600,
                            fontSize: 25,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: ' has been\n sent to your inbox. Please check your email to proceed.',
                          style: GoogleFonts.hankenGrotesk(
                            fontWeight: FontWeight.w300,
                            fontSize: 25,
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            
            // "CONTINUE" button at the bottom
            Container(
              margin: const EdgeInsets.only(bottom: 350), // Space at the bottom before "CONTINUE"
              child: GestureDetector(
                onTap: () {
                  // Add your onTap logic here
                },
                child: Text(
                  'CONTINUE',
                  style: GoogleFonts.hankenGrotesk(
                    fontWeight: FontWeight.w900,
                    fontSize: 30,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

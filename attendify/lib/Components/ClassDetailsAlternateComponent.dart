import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:attendify/Components/AppBarComponent.dart';

class ClassDetailsAlternateComponent extends StatefulWidget {
  @override
  _ClassDetailsAlternateComponentState createState() => _ClassDetailsAlternateComponentState();
}

class _ClassDetailsAlternateComponentState extends State<ClassDetailsAlternateComponent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBarComponent(), // Custom AppBar
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                // "Hard press here to delete room" text
                GestureDetector(
                  onTap: () {
                    // Handle hard press for deleting room
                    // Add your functionality here
                  },
                  child: Column(
                    children: [
                      Text(
                        'Hard press here to',
                        style: GoogleFonts.hankenGrotesk(
                          fontWeight: FontWeight.w400,
                          fontSize: 26,
                          color: const Color(0xff000000).withOpacity(0.2), // Lighter black color
                          height: 1.4,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'delete room',
                        style: GoogleFonts.hankenGrotesk(
                          fontWeight: FontWeight.w400,
                          fontSize: 26,
                          color: const Color(0xff000000).withOpacity(0.2), // Lighter black color
                          height: 1.4,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // "Tap here to update room" text with different opacities
                GestureDetector(
                  onTap: () {
                    // Handle tap for updating room
                    // Add your functionality here
                  },
                  child: Column(
                    children: [
                      Text(
                        'Tap here to',
                        style: GoogleFonts.hankenGrotesk(
                          fontWeight: FontWeight.w400,
                          fontSize: 26,
                          color: const Color(0xff000000).withOpacity(0.3), // Opacity 0.3 for lighter text
                          height: 1.4,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'update',
                        style: GoogleFonts.hankenGrotesk(
                          fontWeight: FontWeight.w400,
                          fontSize: 26,
                          color: const Color(0xff000000), // Brighter black color
                          height: 1.4,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Positioned date and time
                            GestureDetector(
                  onTap: () {
                    // Handle tap for updating room
                    // Add your functionality here
                  },
                  child: Column(
                    children: [
                      Text(
                        'Tap here to',
                        style: GoogleFonts.hankenGrotesk(
                          fontWeight: FontWeight.w400,
                          fontSize: 26,
                          color: const Color(0xff000000).withOpacity(0.3), // Opacity 0.3 for lighter text
                          height: 1.4,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'Download Attendance',
                        style: GoogleFonts.hankenGrotesk(
                          fontWeight: FontWeight.w400,
                          fontSize: 26,
                          color: const Color(0xff000000), // Brighter black color
                          height: 1.4,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
            // Positioned question and answer buttons
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    // Handle tap for the question
                    // Add your functionality here
                  },
                  child: Text(
                    'Do you want to',
                    style: GoogleFonts.hankenGrotesk(
                      fontWeight: FontWeight.w400,
                      fontSize: 26,
                      color: const Color(0xff000000).withOpacity(0.3), // Opacity 0.3 for "Do you want to"
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Handle tap for "start class?"
                    // Add your functionality here
                  },
                  child: Text(
                    'End class?', // Brighter black color for "start class?"
                    style: GoogleFonts.hankenGrotesk(
                      fontWeight: FontWeight.w400,
                      fontSize: 26,
                      color: const Color(0xff000000), // Brighter black color for emphasis
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                // YES and NO buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          // Handle YES tap
                        });
                      },
                      child: Text(
                        'YES',
                        style: GoogleFonts.hankenGrotesk(
                          fontWeight: FontWeight.w900,
                          fontSize: 30,
                          color: const Color(0xff000000), // Brighter black color
                          height: 1.4,
                        ),
                      ),
                    ),
                    const SizedBox(width: 40),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          // Handle NO tap
                        });
                      },
                      child: Text(
                        'NO',
                        style: GoogleFonts.hankenGrotesk(
                          fontWeight: FontWeight.w900,
                          fontSize: 30,
                          color: const Color(0xff000000), // Brighter black color
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

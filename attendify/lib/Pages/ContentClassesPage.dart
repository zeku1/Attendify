import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:attendify/Components/AppBarComponent.dart';
import 'package:attendify/Components/ClassDetailsComponent.dart';
import 'package:attendify/Components/ClassDetailsAlternateComponent.dart';

class ContentClassesPage extends StatefulWidget {
  @override
  _ContentClassesPageState createState() => _ContentClassesPageState();
}

class _ContentClassesPageState extends State<ContentClassesPage> {
  bool _isViewRoomsVisible = true; // Start with grid view by default

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      appBar: AppBarComponent(), // Custom AppBar
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 1.0),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween, // Space between top and bottom
          children: [
            // Align the LIST and GRID to the center top
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 50.0), // Adjust top padding as needed
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment
                          .center, // Center the row horizontally
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              // Toggle view between LIST and GRID
                            });
                          },
                          child: Text(
                            'LIST,',
                            style: GoogleFonts.hankenGrotesk(
                              fontWeight: FontWeight.w900,
                              fontSize: 30,
                              color: _isViewRoomsVisible
                                  ? const Color(
                                      0xff000000) // Highlight when active
                                  : const Color(0xff000000).withOpacity(0.5),
                              height: 32.57 / 25,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              // Toggle view between LIST and GRID
                            });
                          },
                          child: Text(
                            'GRID',
                            style: GoogleFonts.hankenGrotesk(
                              fontWeight: FontWeight.w900,
                              fontSize: 30,
                              color: !_isViewRoomsVisible
                                  ? const Color(
                                      0xff000000) // Highlight when active
                                  : const Color(0xff000000).withOpacity(0.5),
                              height: 32.57 / 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                        height:
                            20), // Space between LIST/GRID and WEB DEVELOPMENT
                    GestureDetector(
                      onTap: () {
                        // Use Navigator to push the ClassDetailsComponent page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ClassDetailsComponent()),
                        );
                      },
                      child: Text(
                        'WEB DEVELOPMENT',
                        style: GoogleFonts.hankenGrotesk(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Colors.black, // Highlight when active
                          height: 19.54 / 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Align 'SCAN' and 'CLASS' at the bottom
            Padding(
              padding: const EdgeInsets.only(
                  bottom: 20.0), // Optional bottom padding
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Center horizontally
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        // Trigger action for SCAN
                      });
                    },
                    child: Text(
                      'SCAN,',
                      style: GoogleFonts.hankenGrotesk(
                        fontWeight: FontWeight.w900,
                        fontSize: 30,
                        color: const Color(0xff000000), // Highlight when active
                        height: 32.57 / 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        // Trigger action for CLASS
                      });
                    },
                    child: Text(
                      'CLASS',
                      style: GoogleFonts.hankenGrotesk(
                        fontWeight: FontWeight.w900,
                        fontSize: 30,
                        color: const Color(0xff000000)
                            .withOpacity(0.5), // Highlight when active
                        height: 32.57 / 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

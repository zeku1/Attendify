import 'package:attendify/API/SessionApi.dart';
import 'package:attendify/Model/Section.dart';
import 'package:attendify/Model/Session.dart';
import 'package:attendify/Pages/ClassViewPage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:attendify/Components/AppBarComponent.dart';

class ClassDetailsPage extends StatefulWidget {
  final Section? section;

  const ClassDetailsPage({super.key, this.section});

  @override
  _ClassDetailsPageState createState() => _ClassDetailsPageState();
}

class _ClassDetailsPageState extends State<ClassDetailsPage> {

  DateTime now = DateTime.now();

  Session? session;
  bool _isLoading = false; // Track loading state
  final SessionApi _sessionApi = SessionApi();

  void startSession() async {
    setState(() {
      _isLoading = true; // Set loading to true when starting
    });

    // Check if section is null before trying to access its id
    if (widget.section == null) {
      setState(() {
        _isLoading = false; // Stop loading in case of error
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Section is null. Cannot start session.')),
      );
      return; // Exit early
    }

    try {
      final fetchedSession = await _sessionApi.startSession(widget.section!.id);
      print('success: $fetchedSession');
      setState(() {
        session = fetchedSession;
        _isLoading = false; // Set loading to false when complete
      });

      if (session != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ClassViewPage(sessionId: fetchedSession!.id,section: widget.section!,),
          ),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false; // Stop loading in case of error
      });
      print('Error starting class session: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error starting class session: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String currentMonthNumber = '${now.month}-';
    String currentDayNumber = '${now.day}';
    String currentYearNumber = '-${now.year} ';
    String formattedTime = DateFormat('hh:mm a').format(now);

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBarComponent(), // Custom AppBar
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: _isLoading // Show loader if loading
            ? Center(child: CircularProgressIndicator())
            : Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
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
                          color: const Color(0xff000000).withOpacity(0.3),
                          height: 1.4,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'delete room',
                        style: GoogleFonts.hankenGrotesk(
                          fontWeight: FontWeight.w400,
                          fontSize: 26,
                          color: const Color(0xff000000).withOpacity(0.3),
                          height: 1.4,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
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
                          color: const Color(0xff000000).withOpacity(0.3),
                          height: 1.4,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'update room',
                        style: GoogleFonts.hankenGrotesk(
                          fontWeight: FontWeight.w400,
                          fontSize: 26,
                          color: const Color(0xff000000),
                          height: 1.4,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    // Handle tap for today's date
                    // Add your functionality here
                  },
                  child: Text(
                    'Today is',
                    style: GoogleFonts.hankenGrotesk(
                      fontWeight: FontWeight.w400,
                      fontSize: 26,
                      color: const Color(0xff000000).withOpacity(0.3),
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Handle tap for month
                      },
                      child: Text(
                        currentMonthNumber,
                        style: GoogleFonts.hankenGrotesk(
                          fontWeight: FontWeight.w400,
                          fontSize: 26,
                          color: const Color(0xff000000).withOpacity(0.3),
                          height: 1.4,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Handle tap for day
                      },
                      child: Text(
                        currentDayNumber,
                        style: GoogleFonts.hankenGrotesk(
                          fontWeight: FontWeight.w400,
                          fontSize: 26,
                          color: const Color(0xff000000),
                          height: 1.4,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Handle tap for year
                      },
                      child: Text(
                        currentYearNumber,
                        style: GoogleFonts.hankenGrotesk(
                          fontWeight: FontWeight.w400,
                          fontSize: 26,
                          color: const Color(0xff000000).withOpacity(0.3),
                          height: 1.4,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Handle tap for time
                      },
                      child: Text(
                        formattedTime,
                        style: GoogleFonts.hankenGrotesk(
                          fontWeight: FontWeight.w400,
                          fontSize: 26,
                          color: const Color(0xff000000),
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    // Handle tap for the question
                  },
                  child: Text(
                    'Do you want to',
                    style: GoogleFonts.hankenGrotesk(
                      fontWeight: FontWeight.w400,
                      fontSize: 26,
                      color: const Color(0xff000000).withOpacity(0.3),
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Handle tap for "start class?"
                  },
                  child: Text(
                    'start class?',
                    style: GoogleFonts.hankenGrotesk(
                      fontWeight: FontWeight.w400,
                      fontSize: 26,
                      color: const Color(0xff000000),
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        startSession(); // Call session start here
                      },
                      child: Text(
                        'YES',
                        style: GoogleFonts.hankenGrotesk(
                          fontWeight: FontWeight.w900,
                          fontSize: 30,
                          color: const Color(0xff000000),
                          height: 1.4,
                        ),
                      ),
                    ),
                    const SizedBox(width: 40),
                    GestureDetector(
                      onTap: () {
                        // Handle NO tap
                      },
                      child: Text(
                        'NO',
                        style: GoogleFonts.hankenGrotesk(
                          fontWeight: FontWeight.w900,
                          fontSize: 30,
                          color: const Color(0xff000000),
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

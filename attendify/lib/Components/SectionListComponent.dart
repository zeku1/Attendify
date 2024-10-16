import 'package:attendify/API/SessionApi.dart';
import 'package:attendify/Model/Section.dart';
import 'package:attendify/Model/Session.dart';
import 'package:attendify/Pages/TeachersDashbaord.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Pages/ClassViewPage.dart';

class SectionListComponent extends StatefulWidget {
  final List<Session> sessions;
  final Section section;
  final bool? isActive;

  const SectionListComponent({
    super.key,
    required this.sessions,
    required this.section,
    this.isActive
  });

  @override
  State<SectionListComponent> createState() => _SectionListComponentState();
}

class _SectionListComponentState extends State<SectionListComponent> {
  bool _isCreateRoomVisible = false;
  final SessionApi sessionApi = SessionApi();

  void endSession() async {
    try {
      final fetchedSession = await sessionApi.endClassSession(widget.section.id);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TeachersDashboard(),
        ),
      );
      print('Session ended');
    } catch (e) {
      print('Failed to end session');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 5.0, left: 18),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isCreateRoomVisible = true;
                    });
                  },
                  child: Text(
                    'LIST',
                    style: GoogleFonts.hankenGrotesk(
                      fontWeight: FontWeight.w900,
                      fontSize: 25,
                      color: _isCreateRoomVisible
                          ? const Color(0xff000000)
                          : const Color(0xff000000).withOpacity(0.5),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isCreateRoomVisible = false;
                    });
                  },
                  child: Text(
                    'GRID',
                    style: GoogleFonts.hankenGrotesk(
                      fontWeight: FontWeight.w900,
                      fontSize: 25,
                      color: !_isCreateRoomVisible
                          ? const Color(0xff000000)
                          : const Color(0xff000000).withOpacity(0.5),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),

        widget.isActive == true
            ? GestureDetector(
          onTap: () {
            endSession();
          },
          child: const Center(
            child: Text('End Session'),
          ),
        )
            : Text(
          widget.section.sectionName, // No need for null check
          style: const TextStyle(fontSize: 20),
        ),

        // List of sessions
        SingleChildScrollView(
          child: Column(
            children: widget.sessions.map((session) {
              return Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          session.startTime, // Display session name
                          style: GoogleFonts.hankenGrotesk(
                            textStyle: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        ),
                        Text(
                          session.date, // Display session name
                          style: GoogleFonts.hankenGrotesk(
                            textStyle: TextStyle(
                                fontSize: 18,
                                color: Colors.black.withOpacity(0.5)
                            ),
                          )
                        ),
                      ],
                    ),
                    Text(
                        session.endTime!, // Display session name
                        style: GoogleFonts.hankenGrotesk(
                          textStyle: TextStyle(
                              fontSize: 18,
                              color: Colors.black.withOpacity(0.5)
                          ),
                        )
                    )

                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

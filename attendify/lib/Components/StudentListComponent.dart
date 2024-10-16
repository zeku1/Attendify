import 'package:attendify/API/SessionApi.dart';
import 'package:attendify/Model/Section.dart';
import 'package:attendify/Model/Session.dart';
import 'package:attendify/Model/StudentModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Pages/ClassViewPage.dart';

class StudentListComponent extends StatefulWidget{
  final List<StudentModel>? students;
  final Section? section;
  final bool? isActive;

  const StudentListComponent({super.key, this.students, this.isActive, this.section});

  @override
  State<StudentListComponent> createState() => _StudentListComponentState();
}

class _StudentListComponentState extends State<StudentListComponent> {
  Session? session;
  bool _isCreateRoomVisible = false;

  final SessionApi sessionApi = SessionApi();



  void endSession() async{
    try {
        final fetchedSession = await sessionApi.endClassSession(widget.section!.id);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ClassViewPage(sessionId: fetchedSession.id,section: widget.section),
          ),
        );
        print('end');
    } catch (e) {
      print('not end');
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
                        // Show CreateRoomComponent
                      });
                    },
                    child: Text(
                      'LIST,',
                      style: GoogleFonts.hankenGrotesk(
                        fontWeight: FontWeight.w900,
                        fontSize: 25,
                        color: _isCreateRoomVisible
                            ? const Color(0xff000000) // Highlight when active
                            : const Color(0xff000000).withOpacity(0.5),
                        // height: 32.57 / 25,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isCreateRoomVisible = false; // Show ViewRoomsComponent
                      });
                    },
                    child: Text(
                      'GRID',
                      style: GoogleFonts.hankenGrotesk(
                        fontWeight: FontWeight.w900,
                        fontSize: 25,
                        color: !_isCreateRoomVisible
                            ? const Color(0xff000000) // Highlight when active
                            : const Color(0xff000000).withOpacity(0.5),
                        // height: 32.57 / 25,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10,),

          widget.isActive == true
              ? GestureDetector(
            onTap: () {
              endSession();
            },
            child: Center(
              child: Text('End Session'),
            ),
          )
              : Text(
            widget.section?.sectionName ?? 'No section available',
            style: TextStyle(fontSize: 20), // Optional styling
          ),

          SingleChildScrollView(
      child: Column(
        children: widget.students?.map((student) {
          return Padding(
            padding: const EdgeInsets.only(left: 10.0,top: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${student.firstName} ${student.lastName}',
                      style: TextStyle(fontSize: 23, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ],
            ),
          );
        }).toList() ?? [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('No students available.'),
          ),
        ],
      ),
    )
        ]
    );
  }
}
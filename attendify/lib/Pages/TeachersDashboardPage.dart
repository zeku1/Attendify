import 'package:attendify/Components/ViewRoomsComponent.dart';
import 'package:flutter/material.dart';
import 'package:attendify/Components/AppBarComponent.dart'; // Import the new AppBarComponent
import 'package:google_fonts/google_fonts.dart';
import 'package:attendify/Components/CreateRoomComponent.dart';

class TeachersDashboard extends StatefulWidget {
  @override
  _TeachersDashboardState createState() => _TeachersDashboardState();
}

class _TeachersDashboardState extends State<TeachersDashboard> {
  bool _isCreateRoomVisible = true; // Boolean to toggle between CreateRoom and ViewRooms

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      appBar: AppBarComponent(), // Custom AppBar
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50.0, left: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isCreateRoomVisible = true; // Show CreateRoomComponent
                      });
                    },
                    child: Text(
                      'CREATE ROOM,',
                      style: GoogleFonts.hankenGrotesk(
                        fontWeight: FontWeight.w900,
                        fontSize: 23,
                        color: _isCreateRoomVisible
                            ? const Color(0xff000000) // Highlight when active
                            : const Color(0xff000000).withOpacity(0.5),
                        height: 32.57 / 25,
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
                      'VIEW ROOMS',
                      style: GoogleFonts.hankenGrotesk(
                        fontWeight: FontWeight.w900,
                        fontSize: 23,
                        color: !_isCreateRoomVisible
                            ? const Color(0xff000000) // Highlight when active
                            : const Color(0xff000000).withOpacity(0.5),
                        height: 32.57 / 25,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
     
  Expanded(       // Display either CreateRoomComponent or ViewRoomsComponent based on the _isCreateRoomVisible flag
  child: _isCreateRoomVisible
  ? CreateRoomComponent()
  : ViewRoomsComponent(),
  ),
            Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}

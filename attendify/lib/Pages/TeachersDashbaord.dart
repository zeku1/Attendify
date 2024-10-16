import 'package:attendify/API/ClassApi.dart';
import 'package:attendify/Components/ViewRooms.dart';
import 'package:attendify/Components/ViewRoomsComponent.dart';
import 'package:attendify/Model/Section.dart';
import 'package:attendify/Routes/AppRoutes.dart';
import 'package:flutter/material.dart';
import 'package:attendify/Components/AppBarComponent.dart'; // Import the new AppBarComponent
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:attendify/Components/CreateRoomComponent.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TeachersDashboard extends StatefulWidget {
  @override
  _TeachersDashboardState createState() => _TeachersDashboardState();
}

class _TeachersDashboardState extends State<TeachersDashboard> {
  SharedPreferences? _prefs;
  final ClassApi _classApi = ClassApi();
  bool _isCreateRoomVisible = false;
  List<Section>? allSections;

  String? _role;
  String? _schoolId;
  int? _id;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeSharedPreferences();
  }

  void _initializeSharedPreferences() async {
    await dotenv.load(fileName: ".env");
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _role = _prefs?.getString('role');
      _schoolId = _prefs?.getString('school_id');
      _id = _prefs?.getInt('teacher_id');
      _isLoading = false;

      // Fetch student data
      _getSections();
    });

    if(_role == null || _id == null){
      Navigator.pushNamed(context, AppRoutes.login);
    }

  }
  // Fetch student details from API
  void _getSections() async {
    if (_id != null) {
      try {
        final listSections = await _classApi.getSectionsByTeacherId(_id!);
        setState(() {
          allSections = listSections;
        });
      } catch (e) {
        print('Error fetching student: $e');

        // Reinitialize the state if the student is null
        setState(() {
          allSections = null; // Set to null, optional
          _isLoading = true;
        });

        // Call _initializeSharedPreferences to reset state
        _initializeSharedPreferences();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      // appBar: AppBarComponent(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                Text(
                  (_schoolId ?? ''),
                  style: GoogleFonts.hankenGrotesk(
                    fontWeight: FontWeight.w300,
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
                    (_role?.toUpperCase() ?? 'Sign in'),
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
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.only(top: 5.0, left: 18),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                        'VIEW ROOM',
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
            SizedBox(height: 40,),
            Expanded(
              // Display either CreateRoomComponent or ViewRoomsComponent based on the _isCreateRoomVisible flag
              child: _isCreateRoomVisible
                  ? CreateRoomComponent(id: _id)
                  : ViewRoom(allSections: allSections ?? []),
            ),

            // Bottom Centered Buttons

          ],
        ),
      ),
    );
  }
}
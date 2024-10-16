import 'package:attendify/API/ClassApi.dart';
import 'package:attendify/API/SessionApi.dart';
import 'package:attendify/Components/ScannerComponent.dart';
import 'package:attendify/Components/StudentListComponent.dart';
import 'package:attendify/Components/TeacherQrAndScanner.dart';
import 'package:attendify/Model/Section.dart';
import 'package:attendify/Model/Session.dart';
import 'package:attendify/Model/StudentModel.dart';
import 'package:attendify/Routes/AppRoutes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:attendify/Components/CreateRoomComponent.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClassPreview extends StatefulWidget {
  final Section? section;

  const ClassPreview({super.key, this.section});

  @override
   ClassPreviewState createState() =>  ClassPreviewState();
}

class  ClassPreviewState extends State <ClassPreview> {
  SharedPreferences? _prefs;
  List<Session>? sessions;
  List<StudentModel>? students;

  Section? section;

  bool _isCreateRoomVisible = false;
  bool? isActive;
  ClassApi classApi = ClassApi();

  String? _role;
  String? _schoolId;
  int? _id;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeSharedPreferences();
  }

  Future<void> _initializeSharedPreferences() async {
    await dotenv.load(fileName: ".env");
    _prefs = await SharedPreferences.getInstance();
    _role = _prefs?.getString('role');
    _schoolId = _prefs?.getString('school_id');
    _id = _prefs?.getInt('teacher_id');

    if (_role == null || _id == null) {
      Navigator.pushNamed(context, AppRoutes.login);
    } else {
      await _getSections();
    }

    setState(() {
      _isLoading = false;
    });
  }

  // Fetch session details from API
  Future<void> _getSections() async {
    if (_id != null && widget.section != null) {
      try {
        final fetchedSection = await classApi.getSection(widget.section!.id);
        if (fetchedSection != null) {
          setState(() {
            section = fetchedSection;
            sessions = fetchedSection!.sessions;
          });
        } else {
          _showErrorDialog('Failed to fetch class session.');
        }
      } catch (e) {
        _showErrorDialog('Error fetching session: $e');
      }
    }
  }

  Future<void> _refresh() async {
    setState(() {
      _isLoading = true; // Show loading indicator during refresh
    });
    await _initializeSharedPreferences(); // Refresh data
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: RefreshIndicator(
        onRefresh: _refresh, // Triggers when user pulls down
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : Column(
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
                  TextButton(
                    onPressed: () {
                      _refresh();
                    },
                    child: Text(
                      (_schoolId ?? ''),
                      style: GoogleFonts.hankenGrotesk(
                        fontWeight: FontWeight.w300,
                        fontSize: 15,
                        color: Color(0x80000000), // 50% opacity black
                        height: 19.54 / 15,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
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
              Expanded(
                child: _isCreateRoomVisible
                    ? Text('hi')
                    : (students != null
                    ? StudentListComponent(
                  students: students!,
                  section: widget.section,
                  isActive: isActive,
                )
                    : Center(child: Text("No student data available."))),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      isActive!?
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isCreateRoomVisible = true; // Show CreateRoomComponent
                          });
                        },
                        child: Text(
                          'SCAN,',
                          style: GoogleFonts.hankenGrotesk(
                            fontWeight: FontWeight.w900,
                            fontSize: 23,
                            color: _isCreateRoomVisible
                                ? const Color(0xff000000) // Highlight when active
                                : const Color(0xff000000).withOpacity(0.5),
                            height: 32.57 / 25,
                          ),
                        ),
                      ):Text(''),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isCreateRoomVisible = false; // Show ViewRoomsComponent
                          });
                        },
                        child: Text(
                          'CLASS',
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

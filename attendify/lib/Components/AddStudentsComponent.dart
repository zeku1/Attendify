import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:attendify/Components/AppBarComponent.dart';

class AddStudentsPage extends StatefulWidget {
  @override
  _AddStudentsPageState createState() => _AddStudentsPageState();
}

class _AddStudentsPageState extends State<AddStudentsPage> {
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
            // Add your content here, for example, a title and a form for adding students

            // Additional widgets like input fields or buttons can go here
          ],
        ),
      ),
    );
  }
}

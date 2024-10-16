import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:attendify/Components/AppBarComponent.dart';

class AddStudentsPage extends StatefulWidget {
  @override
  _AddStudentsPageState createState() => _AddStudentsPageState();
}

class _AddStudentsPageState extends State<AddStudentsPage> {
  final List<Map<String, String>> _students = [
    {'name': 'Zedrick Zafra'},
    {'name': 'Nathaniel Abadies'},
    {'name': 'Loyce Nantes'},
    {'name': 'Ezekiel Lucena'},
    {'name': 'Xavier Fuentes'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBarComponent(), // Custom AppBar
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          children: [
            // Centering the group of texts at the top
            Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Check ',
                      style: GoogleFonts.hankenGrotesk(
                        fontWeight: FontWeight.w400,
                        fontSize: 26,
                        color: const Color(0xff000000), // Solid black
                      ),
                    ),
                    TextSpan(
                      text: 'Student to ',
                      style: GoogleFonts.hankenGrotesk(
                        fontWeight: FontWeight.w400,
                        fontSize: 26,
                        color: const Color(0xff000000).withOpacity(0.3), // Low opacity black
                      ),
                    ),
                    TextSpan(
                      text: 'Add',
                      style: GoogleFonts.hankenGrotesk(
                        fontWeight: FontWeight.w400,
                        fontSize: 26,
                        color: const Color(0xff000000), // Solid black
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Display the list of students with check marks
            Expanded(
              child: ListView.builder(
                itemCount: _students.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.check, color: Colors.black), // Check mark
                    title: Text(
                      _students[index]['name']!,
                      style: GoogleFonts.hankenGrotesk(
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 50.0), // Aligning with space
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
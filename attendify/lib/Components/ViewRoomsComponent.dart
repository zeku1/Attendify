import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewRoomsComponent extends StatefulWidget {
  @override
  _ViewRoomsComponentState createState() => _ViewRoomsComponentState();
}

class _ViewRoomsComponentState extends State<ViewRoomsComponent> {
  bool _isGridView = true; // Start with grid view by default

  // Sample rooms for testing
  final List<Map<String, String>> _rooms = [
    {
      'title': 'Web Development',
      'instructor': 'Christina Calva',
      'semester': '1st sem',
    },
    {
      'title': 'Simplified Mandarin',
      'instructor': 'Adriana Nantes',
      'semester': '1st sem',
    },
    {
      'title': 'Data Analytics',
      'instructor': 'Jorhen Nacasabog',
      'semester': '1st sem',
    },
    {
      'title': 'Globalization and Economics',
      'instructor': 'Haize Hidalgo',
      'semester': '1st sem',
    },
  ];

  // Helper method to get initials for the picture placeholder
  String _getInitials(String title) {
    List<String> words = title.split(' ');
    String initials = words.length > 1
        ? '${words[0][0]}${words[1][0]}' // Get first letter of first two words
        : title[0]; // Single word title fallback
    return initials.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF), // Set the background color
      appBar: AppBar(
        title: Text('View Rooms', style: GoogleFonts.hankenGrotesk()),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Expanded scrollable content (Grid/List view)
              _isGridView ? _buildGridView() : _buildListView(),

              // Buttons at the bottom of the screen
              _buildToggleButtons(),
            ],
          ),
        ),
      ),
    );
  }

  // GridView builder
  Widget _buildGridView() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(), // Prevent nested scrolling
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Two cards per row
        crossAxisSpacing: 10,
        mainAxisSpacing: 20,
        childAspectRatio: 10 / 15, // Adjust the card size
      ),
      itemCount: _rooms.length,
      itemBuilder: (context, index) {
        return _buildRoomCard(_rooms[index]);
      },
    );
  }

  // ListView builder
  Widget _buildListView() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(), // Prevent nested scrolling
      padding: const EdgeInsets.all(10),
      itemCount: _rooms.length,
      itemBuilder: (context, index) {
        return _buildRoomCard(_rooms[index]);
      },
    );
  }

  // Widget to build the room card
  Widget _buildRoomCard(Map<String, String> room) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Color(0XffD9D9D9),
              child: Text(
                _getInitials(room['title']!),
                style: GoogleFonts.hankenGrotesk(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              room['title']!,
              style: GoogleFonts.hankenGrotesk(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 5),
            Text(
              room['instructor']!,
              style: GoogleFonts.hankenGrotesk(
                fontSize: 14,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 5),
            Text(
              room['semester']!,
              style: GoogleFonts.hankenGrotesk(
                fontSize: 14,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // Toggle buttons to switch between List and Grid view
  Widget _buildToggleButtons() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.grey[200], // Optional background for buttons container
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildToggleButton("List", !_isGridView, () {
            setState(() {
              _isGridView = false;
            });
          }),
          const SizedBox(width: 10),
          _buildToggleButton("Grid", _isGridView, () {
            setState(() {
              _isGridView = true;
            });
          }),
        ],
      ),
    );
  }

  // Helper widget to create a toggle button
  Widget _buildToggleButton(String title, bool isActive, VoidCallback onPressed) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: isActive ? Colors.black : Colors.grey.shade300,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Text(
        title,
        style: GoogleFonts.hankenGrotesk(
          color: isActive ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

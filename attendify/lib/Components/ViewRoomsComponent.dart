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
    {'title': 'Web Development', 'instructor': 'Christina Calva', 'semester': '1st sem'},
    {'title': 'Simplified Mandarin', 'instructor': 'Adriana Nantes', 'semester': '1st sem'},
    {'title': 'Data Analytics', 'instructor': 'Jorhen Nacasabog', 'semester': '1st sem'},
    {'title': 'Globalization and Economics', 'instructor': 'Haize Hidalgo', 'semester': '1st sem'},
  ];

  // Helper method to get initials for the picture placeholder
  String _getInitials(String title) {
    List<String> words = title.split(' ');
    return words.length > 1 ? '${words[0][0]}${words[1][0]}' : title[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        title: Text('View Rooms', style: GoogleFonts.hankenGrotesk()),
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildScrollableContent(), // Moved buttons inside scrollable area
          ),
        ],
      ),
    );
  }

  Widget _buildScrollableContent() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 1.0), // Reduced horizontal padding
            child: _isGridView ? _buildGridView() : _buildListView(),
          ),
          _buildToggleButtons(), // Moved toggle buttons inside scrollable area
        ],
      ),
    );
  }

  // GridView builder
  Widget _buildGridView() {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(vertical: 10.0), // Reduced padding
      shrinkWrap: true, // Important to prevent infinite height errors
      physics: const NeverScrollableScrollPhysics(), // Disable GridView's own scrolling
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8, // Adjusted spacing
        mainAxisSpacing: 12, // Adjusted spacing
        childAspectRatio: 10 / 13, // Adjusted aspect ratio to fit better
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
      padding: const EdgeInsets.symmetric(vertical: 10.0), // Reduced padding
      shrinkWrap: true, // Prevents ListView from taking infinite height
      physics: const NeverScrollableScrollPhysics(), // Disable ListView's own scrolling
      itemCount: _rooms.length,
      itemBuilder: (context, index) {
        return _buildRoomCard(_rooms[index]);
      },
    );
  }

  // Widget to build the room card
  Widget _buildRoomCard(Map<String, String> room) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12.0), // Reduced padding for a compact card
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: const Color(0XffD9D9D9),
              child: Text(
                _getInitials(room['title']!),
                style: GoogleFonts.hankenGrotesk(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              room['title']!,
              style: GoogleFonts.hankenGrotesk(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              room['instructor']!,
              style: GoogleFonts.hankenGrotesk(
                fontSize: 14,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
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

  // Toggle buttons widget
  Widget _buildToggleButtons() {
    return Container(
      padding: const EdgeInsets.all(10), // Reduced padding
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildToggleButton("List", !_isGridView, () {
            setState(() {
              _isGridView = false;
            });
          }),
          const SizedBox(width: 8), // Reduced spacing between buttons
          _buildToggleButton("Grid", _isGridView, () {
            setState(() {
              _isGridView = true;
            });
          }),
        ],
      ),
    );
  }

  // Single button widget for toggling between List and Grid view
  Widget _buildToggleButton(String title, bool isActive, VoidCallback onPressed) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: isActive ? Colors.black : Colors.white,
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

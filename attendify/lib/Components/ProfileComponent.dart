import 'package:attendify/Model/StudentModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'GenerateQr.dart';

class ProfileComponent extends StatefulWidget {
  final StudentModel? student;

  const ProfileComponent({Key? key, required this.student}) : super(key: key);

  @override
  State<ProfileComponent> createState() => _ProfileComponentState();
}

class _ProfileComponentState extends State<ProfileComponent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.student != null)
          Center(
            child: Column(
              children: [
                GenerateQrComponent(qrData: widget.student!.schoolId, size: 220),
                SizedBox(height: 25),
                Text(
                  '${widget.student!.firstName} ${widget.student!.lastName}',
                  style: GoogleFonts.hankenGrotesk(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.black
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  widget.student!.email,
                  style: GoogleFonts.hankenGrotesk(
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                      color: Colors.black.withOpacity(0.5)
                  ),
                ),
              ],
            ),
          ),
        SizedBox(height: 60),
        Center(
          child: Text(
            'Classes enrolled',
            style: GoogleFonts.hankenGrotesk(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Colors.black
            ),
          ),
        ),
        SizedBox(height: 10),
        // Flexible or Expanded to allow the list to take up remaining space
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: widget.student!.sections.map((section) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            section.sectionName,
                            style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 2),
                          Text(
                            section.teacherName,
                            style: TextStyle(fontSize: 19, color: Colors.grey),
                          ),
                        ],
                      ),
                      Text(
                        section.semester,
                        style: TextStyle(fontSize: 21, color: Colors.black54),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}

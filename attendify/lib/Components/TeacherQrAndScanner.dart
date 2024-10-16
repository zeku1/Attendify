import 'package:attendify/Components/GenerateQr.dart';
import 'package:attendify/Components/TeacherCamera.dart';
import 'package:attendify/Model/StudentModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TeacherQrScanner extends StatefulWidget{
  final int? sessionId;

  const TeacherQrScanner({super.key, this.sessionId});

  @override
  State<TeacherQrScanner> createState() => _StudentListComponentState();
}

class _StudentListComponentState extends State<TeacherQrScanner> {

  bool _isCreateRoomVisible = true;

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
                      'GENERATE QR,',
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
                      'CAMERA',
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
          Expanded(
              child: _isCreateRoomVisible? qrPage() : TeacherCamera(sessionId: widget.sessionId!)
          )
        ]
    );
  }

  qrPage(){
    return Container(
      margin: EdgeInsets.only(top:80),
      child: Column(
        children: [
          Center(
            child: Text(
                'Please Scan to join class.',
              style: GoogleFonts.hankenGrotesk(
                textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.black.withOpacity(0.5)
                )
              ),
            ),
          ),
          SizedBox(height: 20,),
          GenerateQrComponent(qrData: widget.sessionId.toString(), size: 300),
        ],
      ),
    );
  }
}
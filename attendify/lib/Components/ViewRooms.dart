import 'package:attendify/Model/Section.dart';
import 'package:attendify/Pages/ClassPreview.dart';
import 'package:attendify/Widgets/ListWidget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Pages/ClassViewPage.dart';

class ViewRoom extends StatefulWidget {
  final List<Section>? allSections;

  const ViewRoom({super.key, this.allSections});

  @override
  State<ViewRoom> createState() => _ViewRoomState();
}

class _ViewRoomState extends State<ViewRoom> {
  bool _isCreateRoomVisible = false;

  @override
  Widget build(BuildContext context) {
    return _viewRoom();
  }

  _viewRoom(){
    return Container(
      child: Column(
        children: [

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: widget.allSections!.map((section) {
                  return GestureDetector(
                    onTap: (){
                      MaterialPageRoute(
                          builder: (context) => ClassPreview(section: section,)
                      );
                    },
                      child: ListWidget(section: section));
                }).toList(),
              ),
            ),
          ),


          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                              _isCreateRoomVisible = true; // Show CreateRoomComponent
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
              ],
            ),
          )
        ],
      ),
    );
  }
}
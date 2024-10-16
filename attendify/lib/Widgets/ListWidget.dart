import 'package:attendify/Model/Section.dart';
import 'package:flutter/material.dart';

import '../Pages/ClassPreview.dart';
import '../Pages/ClassViewPage.dart';

class ListWidget extends StatefulWidget{
  final Section? section;

  const ListWidget({super.key, this.section});
  @override
  State<ListWidget> createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  @override
  Widget build(BuildContext context) {
    return _listWidget();
  }

  Container _listWidget(){
    return Container(
      child: GestureDetector(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ClassPreview(section: widget.section!)
            ),
          );
        },
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.section!.sectionName,
                      style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 2),
                    Text(
                      widget.section!.teacherName,
                      style: TextStyle(fontSize: 19, color: Colors.grey),
                    ),
                  ],
                ),
                Text(
                  widget.section!.semester,
                  style: TextStyle(fontSize: 21, color: Colors.black54),
                ),
              ],
            ),
          ),
      )
    );
  }
}
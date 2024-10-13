import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:attendify/Routes/AppRoutes.dart';

class AppBarComponent extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.SignIn);
            },
            child: Text( // Add 'child' property
              'ATTENDIFY',
              style: GoogleFonts.hankenGrotesk(
                fontWeight: FontWeight.w900,
                fontSize: 15,
                color: Color(0x80000000), // 50% opacity black
                height: 19.54 / 15,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.logout);
            },
            child: Text(
              'TEACHER',
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
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(70.0); // Adjust height as needed
}

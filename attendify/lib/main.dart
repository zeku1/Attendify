import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:attendify/Routes/AppRoutes.dart';
import 'package:flutter/material.dart';

Future main() async {
await dotenv.load(fileName: ".env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Attendify',
      initialRoute: AppRoutes.scanner, // Set initial route
      routes: AppRoutes.getRoutes(),
      debugShowCheckedModeBanner: false,
    );
  }
}

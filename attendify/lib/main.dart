import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:attendify/Routes/AppRoutes.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is fully initialized

  // Load the .env file
  await dotenv.load(fileName: ".env");

  final SharedPreferences _prefs = await SharedPreferences.getInstance();
  _prefs.setString('url', 'http://192.168.0.103:8000/api/v1'); // Set the URL

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Attendify',
      initialRoute: AppRoutes.login, // Set initial route
      routes: AppRoutes.getRoutes(),
      debugShowCheckedModeBanner: false,
    );
  }
}
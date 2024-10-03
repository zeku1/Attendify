import 'package:attendify/Pages/SignInPage.dart';
import 'package:attendify/Pages/Registration.dart';
import 'package:flutter/material.dart';
import 'package:attendify/Pages/Home.dart';
import 'package:attendify/Pages/TeachersLandingPage.dart';

class AppRoutes {
  static const home = '/';
  static const SignIn = '/SignIn';
  static const registration = '/registration'; // Fixed spelling
  static const TeachersLanding = '/TeachersLanding';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      home: (context) => HomePage(),  // Set the LandingPage as the home page
      SignIn: (context) => SignInPage(),
      registration: (context) => Registration(), // Fixed spelling
      TeachersLanding: (context) => TeachersLandingPage(),
    };
  }
}

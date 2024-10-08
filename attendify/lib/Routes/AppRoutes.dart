import 'package:attendify/Pages/SignInPage.dart';
import 'package:attendify/Pages/Registration.dart';
import 'package:attendify/Pages/TeachersDashboardPage.dart';
import 'package:flutter/material.dart';
import 'package:attendify/Pages/Home.dart';
//import 'package:attendify/Pages/TeachersDashboardPage.dart';
//import 'package:attendify/Pages/ViewRoomsPage.dart';


class AppRoutes {
  static const home = '/';
  static const SignIn = '/SignIn';
  static const registration = '/registration'; // Fixed spelling
  static const teachersDashboard = '/teachersDashboard';
  //static const ViewRoomsPageRoute = '/ViewRoomsPage';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      home: (context) => HomePage(),  // Set the LandingPage as the home page
      SignIn: (context) => SignInPage(),
      registration: (context) => Registration(), // Fixed spelling
      teachersDashboard: (context) => TeachersDashboard(),
      //ViewRoomsPageRoute: (context) => ViewRoomsPage(), // Define ViewRoomsPage here
    };
  }
}

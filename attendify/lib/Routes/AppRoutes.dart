import 'package:attendify/Pages/SignInPage.dart';
import 'package:attendify/Pages/Registration.dart';
import 'package:attendify/Pages/TeachersDashboardPage.dart';
import 'package:flutter/material.dart';
import 'package:attendify/Pages/Home.dart';
import 'package:attendify/Components/AddStudentsComponent.dart';
import 'package:attendify/Pages/ContentClassesPage.dart';
import 'package:attendify/Components/ClassDetailsAlternateComponent.dart';
import 'package:attendify/Pages/Verify.dart';
import 'package:attendify/Pages/LogoutPage.dart';

class AppRoutes {
  static const home = '/';
  static const SignIn = '/SignIn';
  static const registration = '/registration'; // Fixed spelling
  static const teachersDashboard = '/teachersDashboard';
  static const addStudents = '/addStudents';
  static const contentClasses = '/contentClasses';
  static const classDetailsAlt = '/classDetailsAlt';
  static const verify = '/verify';
  static const logout = '/logout'; 

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      home: (context) => HomePage(), // Set the LandingPage as the home page
      SignIn: (context) => SignInPage(),
      registration: (context) => Registration(), // Fixed spelling
      teachersDashboard: (context) => TeachersDashboard(),
      addStudents: (context) => AddStudentsPage(),
      contentClasses: (context) => ContentClassesPage(), // Fixed the assignment here
      classDetailsAlt: (context) => ClassDetailsAlternateComponent(),
      verify: (context) => Verify(),
      logout: (context) => LogoutPage(),
    };
  }
}

import 'package:attendify/Pages/AddStudentPage.dart';
import 'package:attendify/Pages/ClassDetailsPage.dart';
import 'package:attendify/Pages/Home.dart';
import 'package:attendify/Pages/LoginPage.dart';
import 'package:attendify/Pages/StudentDashboard.dart';
import 'package:attendify/Pages/TeachersDashbaord.dart';
import 'package:flutter/material.dart';

import '../Pages/LoginPage.dart';
import '../Pages/Registration.dart';

class AppRoutes {
  static const home = '/';
  static const login = '/login';
  static const landing = '/landing';
  static const registration = '/registration';
  static const studentDashboard = '/student-dashboard';
  static const teachersDashboard = '/teachers-dashboard';
  static const addStudent = '/add-student';
  static const classDetails = '/class-details';

  static Map<String, WidgetBuilder> getRoutes(){
    return{
      home: (context) => HomePage(),
      login: (context) => LoginPage(),
      // landing: (context) => LandingPage(),
      registration: (context) => Registration(),
      studentDashboard : (context) => ScannerPage(),
      teachersDashboard: (context) => TeachersDashboard(),
      addStudent: (context) => AddStudentsPage(),
    };
  }
}

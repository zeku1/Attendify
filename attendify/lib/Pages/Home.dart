import 'package:attendify/Components/ViewRoomsComponent.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return _homePage();
  }

 Scaffold _homePage(){
    return Scaffold(
      body: Column(
        children: [
          ViewRoomsComponent()
        ],
      )
    );
 }

}
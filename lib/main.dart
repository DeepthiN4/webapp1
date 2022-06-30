import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:webapp/pages/homepage.dart';
import 'package:webapp/pages/signin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // uId = gnpH1r191xOYLMIsIZgvxNSx5X53;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Web App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "OverpassRegular",
        primaryColor: Color(0xff3185FC),
        scaffoldBackgroundColor: Color(0xfffffaff),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SignIn()   /* Home(userEmail: 'ndeepthi898@gmail.com',  username: 'Deep')*/
      
            );
    
  }
}
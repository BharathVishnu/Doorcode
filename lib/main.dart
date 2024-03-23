import 'package:flutter/material.dart';
import 'splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Splash Screen App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'BebasNeue', //default font
      ),
      home: SplashScreen(),//splash screen made default
    );
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'login.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Simulate a long-running task by delaying for 3 seconds
    Timer(Duration(seconds: 3), () {
      Get.to(Login());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Change to your desired background color
      body: Center(
        child: Stack(
          children: [
            // Centered background image
            Positioned.fill(
              child: Image.asset(
                'assets/logo.png', // Replace with your image asset
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:async';
import 'package:doorcode_nfc/controller/auth_controller.dart';
import 'package:doorcode_nfc/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:doorcode_nfc/controller/auth_controller.dart';

import 'login.dart'; // Import your AuthController

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      init: AuthController(),
      builder: (authController) {
        return Scaffold(
          backgroundColor: Colors.white,
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
      },
      
    );
  }
}

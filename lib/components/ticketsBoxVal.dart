import 'package:doorcode_nfc/screens/tickets.dart';
import 'package:doorcode_nfc/screens/validate_ticket.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TicketsBoxVal extends StatelessWidget {
  final String backgroundImagePath;
  final String iconPath1;
  final String iconPath2;
  final String text1;
  final String text2;
  final String text3;
  final int eventId;

  const TicketsBoxVal({
    Key? key,
    required this.backgroundImagePath,
    required this.iconPath1,
    required this.iconPath2,
    required this.text1,
    required this.text2,
    required this.text3, 
    required this.eventId,
  }) : super(key: key);

  Future<void> _authenticate(BuildContext context) async {
    final LocalAuthentication _localAuthentication = LocalAuthentication();
    try {
      bool isAuthenticated = await _localAuthentication.authenticate(
        localizedReason: 'Authenticate to access your nfc ticket',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: false,
        ),
      );
      if (isAuthenticated) {
        Get.to(NFCTicketVal(eventId: eventId,));
      } else {
        // Authentication failed
        print('Authentication failed');
      }
    } on PlatformException catch (e) {
      // Platform-specific error handling
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _authenticate(context),
      child: Container(
        width: 320,
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), // Make the container rounded
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 3,
              blurRadius: 7,
              offset: Offset(0, 9), // changes position of shadow
            ),
          ],
          image: DecorationImage(
            image: NetworkImage(backgroundImagePath), // Set background image
            fit: BoxFit.cover, // Cover the entire container
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
                10), // Match the container's border radius
            color: Colors.black
                .withOpacity(0.5), // Semi-transparent black background
          ),
          child: Padding(
            padding: const EdgeInsets.all(22.0), // Add padding for the text
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Align text to the left
              children: [
                Text(
                  text1,
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Image.asset(
                      iconPath1,
                      width: 10,
                      height: 10,
                      color: Colors.white,
                    ),
                    SizedBox(width: 10),
                    Text(
                      text2,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Image.asset(
                      iconPath2,
                      width: 10,
                      height: 10,
                      color: Colors.white,
                    ),
                    SizedBox(width: 10),
                    Text(
                      text3,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

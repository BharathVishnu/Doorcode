import 'package:doorcode_nfc/components/bar.dart';
import 'package:doorcode_nfc/components/profileBar.dart';
import 'package:doorcode_nfc/screens/accountInfo.dart';
import 'package:doorcode_nfc/screens/event_registration_page.dart';
import 'package:doorcode_nfc/screens/listedEvents.dart';
import 'package:doorcode_nfc/screens/tickets.dart';
import 'package:doorcode_nfc/screens/validate.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/auth_controller.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: Bar(
          text: 'NAME',
          iconData: Icons.account_circle,
          onPressed: () {},
        ),
        body: Column(
          children: [
            CustomContainer(
              iconPath: 'assets/logo.png',
              name: 'YOUR EVENTS',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListedEvents()),
                );
              },
            ),
            CustomContainer(
              iconPath: 'assets/logo.png',
              name: 'ACCOUNT INFORMATION',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AccountInfo()),
                );
              },
            ),
            CustomContainer(
              iconPath: 'assets/logo.png',
              name: 'LIST YOUR SHOW',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EventRegistrationPage()),
                );
              },
            ),
            CustomContainer(
              iconPath: 'assets/logo.png',
              name: 'LOGOUT',
              onPressed: () {
                AuthController.instance.signOut();
              },
            ),
            SizedBox(
              height: 250,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text('SHARE          |            RATE')],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text('0.0.1')],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

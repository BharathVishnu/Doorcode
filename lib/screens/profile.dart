import 'package:doorcode_nfc/components/bar.dart';
import 'package:doorcode_nfc/components/profileBar.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: Bar(text: 'NAME', iconData: Icons.account_circle, onPressed: () {},),
        body: Column(
          children: [
            CustomContainer(iconPath: 'assets/logo.png', name: 'YOUR EVENTS'),
            CustomContainer(iconPath: 'assets/logo.png', name: 'ACCOUNT INFORMATION'),
            CustomContainer(iconPath: 'assets/logo.png', name: 'REWARDS'),
            CustomContainer(iconPath: 'assets/logo.png', name: 'LIST YOUR SHOW'),
            CustomContainer(iconPath: 'assets/logo.png', name: 'SETTINGS'),
            CustomContainer(iconPath: 'assets/logo.png', name: 'LOGOUT'),
            SizedBox(height: 100,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Text('SHARE          |            RATE')
                ],),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('0.0.1')
                  ],)
              ],
            )

          ],
          
        ),
      ),
    );
  }
}

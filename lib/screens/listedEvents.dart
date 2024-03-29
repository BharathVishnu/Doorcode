import 'package:flutter/material.dart';
import 'package:doorcode_nfc/components/ticketsBox.dart';

class ListedEvents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.only(left: 12, bottom: 8.0),
          child: Text(
            'LISTED EVENTS',
            style: TextStyle(color: Colors.black, fontSize: 32),
            textAlign: TextAlign.left,
          ),
        ),
        centerTitle: false,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              TicketsBox(backgroundImagePath: 'assets/hestia2.png', iconPath1: 'assets/logo.png', iconPath2: 'assets/logo.png', text1: 'HESTIA', text2: '22 MAR', text3: 'KOLLAM'),
              SizedBox(height: 24,),
              TicketsBox(backgroundImagePath: 'assets/hestia2.png', iconPath1: 'assets/logo.png', iconPath2: 'assets/logo.png', text1: 'HESTIA', text2: '22 MAR', text3: 'KOLLAM'),
              SizedBox(height: 24,),
              TicketsBox(backgroundImagePath: 'assets/hestia2.png', iconPath1: 'assets/logo.png', iconPath2: 'assets/logo.png', text1: 'HESTIA', text2: '22 MAR', text3: 'KOLLAM'),
              SizedBox(height: 24,),
              TicketsBox(backgroundImagePath: 'assets/hestia2.png', iconPath1: 'assets/logo.png', iconPath2: 'assets/logo.png', text1: 'HESTIA', text2: '22 MAR', text3: 'KOLLAM'),
              SizedBox(height: 24,),
              TicketsBox(backgroundImagePath: 'assets/hestia2.png', iconPath1: 'assets/logo.png', iconPath2: 'assets/logo.png', text1: 'HESTIA', text2: '22 MAR', text3: 'KOLLAM'),
              SizedBox(height: 24,),
            ],
          ),
        ),
      ),
    );
  }
}

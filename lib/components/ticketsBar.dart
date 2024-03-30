import 'package:flutter/material.dart';

class TicketsBar extends StatelessWidget {
  final String iconPath; // Path to the icon in the assets folder
  final String name;
  final Function()? onPressed;

  const TicketsBar({
    Key? key,
    required this.iconPath,
    required this.name,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 90, // Height of the app bar
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              color: Colors.black,
              width: 2.0, // Adjust the width as needed
            ),
          ),
        ),
        child: Row(
          children: [

            SizedBox(width: 32.0),
            Text(
              'YOUR TICKETS',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(), 
          ],
        ),
      ),
    );
  }
}

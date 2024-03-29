import 'package:flutter/material.dart';

class TicketsBox extends StatelessWidget {
  final String backgroundImagePath;
  final String iconPath1;
  final String iconPath2;
  final String text1;
  final String text2;
  final String text3;

  const TicketsBox({
    Key? key,
    required this.backgroundImagePath,
    required this.iconPath1,
    required this.iconPath2,
    required this.text1,
    required this.text2,
    required this.text3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
          image: AssetImage(backgroundImagePath), // Set background image
          fit: BoxFit.cover, // Cover the entire container
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(22.0), // Add padding for the text
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
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
    );
  }
}

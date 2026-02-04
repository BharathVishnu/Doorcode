import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final String iconPath; // Path to the icon in the assets folder
  final String name;
  final Function()? onPressed;

  const CustomContainer({
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
              width: 1.0, // Adjust the width as needed
            ),
          ),
        ),
        child: Row(
          children: [
            Image.asset(
              iconPath,
              color: Colors.black,
              height: 30,
              width: 30,
            ),
            SizedBox(width: 12.0),
            Text(
              name,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            IconButton(
              icon: Icon(
                Icons.arrow_forward,
                color: Colors.black,
                size: 30,
              ),
              onPressed: onPressed,
            ),
          ],
        ),
      ),
    );
  }
}

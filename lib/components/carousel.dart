import 'package:flutter/material.dart';
import 'carouselcon.dart';

class Carousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      child:
      Container(
      padding: EdgeInsets.all(22.0),
      height: 97.0,
      width: MediaQuery.of(context).size.width,
      color: Colors.white, // Adjust the height as needed
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(width: 25.0),
            ScrollableElement(
              image: 'assets/logo.png',
              label: 'Concerts',
            ),
            SizedBox(width: 75.0),
            ScrollableElement(
              image: 'assets/logo.png',
              label: 'Sports',
            ),
            SizedBox(width: 75.0),
            ScrollableElement(
              image: 'assets/logo.png',
              label: 'Clubs',
            ),
            SizedBox(width: 75.0),
            ScrollableElement(
              image: 'assets/logo.png',
              label: 'Standups',
            ),
            SizedBox(width: 75.0),// Add more ScrollableElements here as needed
          ],
        ),
      ),
    ));
  }
}

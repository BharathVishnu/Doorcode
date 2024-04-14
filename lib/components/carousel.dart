import 'package:flutter/material.dart';
import 'carouselcon.dart';

class Carousel extends StatelessWidget {
  final Function(String) onIconClicked;

  const Carousel({Key? key, required this.onIconClicked}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            height: 87.0,
            width: MediaQuery.of(context).size.width,
            color: Colors.white, // Adjust the height as needed
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(width: 35.0),
                  ScrollableElement(
                    image: 'assets/logo.png',
                    label: 'Concerts',
                    onTap: () {
                      onIconClicked('Concerts');
                    },
                  ),
                  SizedBox(width: 55.0),
                  ScrollableElement(
                    image: 'assets/logo.png',
                    label: 'Clubs',
                    onTap: () {
                      onIconClicked('Clubs');
                    },
                  ),
                  SizedBox(width: 55.0),
                  ScrollableElement(
                    image: 'assets/logo.png',
                    label: 'Sports',
                    onTap: () {
                      onIconClicked('Sports');
                    },
                  ),
                  SizedBox(width: 55.0),
                  ScrollableElement(
                    image: 'assets/logo.png',
                    label: 'Standups',
                    onTap: () {
                      onIconClicked('Standups');
                    },
                  ),
                  SizedBox(width: 50.0),
                  // Add more ScrollableElements here as needed
                ],
              ),
            ),
          ),
          SizedBox(
              height:
                  20.0), // Add some space between the container and the text
          Padding(
            padding: const EdgeInsets.only(left: 30.0), // Add left margin
            child: Text(
              'UPCOMING EVENTS',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

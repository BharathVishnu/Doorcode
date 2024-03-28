import 'package:flutter/material.dart';

class ScrollableElement extends StatelessWidget {
  final String image;
  final String label;

  const ScrollableElement({
    Key? key,
    required this.image,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          image,
          height: 28.0, // Adjust the height of the image
          width: 28.0, // Adjust the width of the image
          color: Colors.black,
        ),
        SizedBox(height: .0),
        Text(
          label,
          style: TextStyle(color: Colors.black),
        ),
      ],
    );
  }
}

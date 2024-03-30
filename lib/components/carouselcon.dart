import 'package:flutter/material.dart';

class ScrollableElement extends StatelessWidget {
  final String image;
  final String label;
  final VoidCallback onTap;

  const ScrollableElement({
    Key? key,
    required this.image,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector
    (
      onTap: onTap,
      child:Column(
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
    ));
  }
}

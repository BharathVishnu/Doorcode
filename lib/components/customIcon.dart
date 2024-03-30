import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {
  final String imagePath;

  CustomIcon({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return ImageIcon(
      AssetImage(imagePath),
      color: Colors.black, // Customize the color if needed
    );
  }
}

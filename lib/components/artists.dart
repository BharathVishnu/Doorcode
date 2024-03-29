import 'package:flutter/material.dart';

class ScrollableCircleRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150, // Set a fixed height for the container
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          CircleItem(imagePath: 'assets/hestia.png', label: 'ARJITH SINGH'),
          CircleItem(imagePath: 'assets/hestia.png', label: 'ARJITH SINGH'),
          CircleItem(imagePath: 'assets/hestia.png', label: 'ARJITH SINGH'),
          CircleItem(imagePath: 'assets/hestia.png', label: 'ARJITH SINGH'),
          CircleItem(imagePath: 'assets/hestia.png', label: 'ARJITH SINGH'),
          CircleItem(imagePath: 'assets/hestia.png', label: 'ARJITH SINGH'),
          // Add more CircleItem widgets as needed
        ],
      ),
    );
  }
}

class CircleItem extends StatelessWidget {
  final String imagePath;
  final String label;

  const CircleItem({
    Key? key,
    required this.imagePath,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: 80,
              height: 90,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Text(label),
        ],
      ),
    );
  }
}

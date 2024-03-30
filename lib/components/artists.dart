import 'package:flutter/material.dart';

class ScrollableCircleRow extends StatelessWidget {
  final List<String> artists;

  const ScrollableCircleRow({Key? key, required this.artists})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: artists.length,
        itemBuilder: (context, index) {
          return CircleItem(
              imagePath: 'assets/hestia.png', label: artists[index]);
        },
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

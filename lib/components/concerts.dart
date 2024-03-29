import 'package:flutter/material.dart';
import 'eventBox.dart';

class Concerts extends StatelessWidget {
  const Concerts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 20.0, right: 10.0, left: 2.0),
        child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 30,
          crossAxisSpacing: 12,
          childAspectRatio: 1
        ),
        children: [
          MyBox('assets/hestia.png'),
          MyBox('assets/hestia2.png'),
          MyBox('assets/hestia2.png'),
          MyBox('assets/proshow.png'),
          MyBox('assets/proshow.png'),
          MyBox('assets/hestia.png'),
          MyBox('assets/hestia.png'),
          MyBox('assets/hestia.png'),

        ],
      ),)
    );
  }
}


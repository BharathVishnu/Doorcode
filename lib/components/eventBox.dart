import 'package:doorcode_nfc/screens/booking.dart';
import 'package:flutter/material.dart';

class MyBox extends StatefulWidget {
  final int event_id;
  final String email;
  final String imagePath;

  MyBox(this.imagePath, this.event_id, this.email);

  @override
  _MyBoxState createState() => _MyBoxState();
}

class _MyBoxState extends State<MyBox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Booking(
                      eventId: widget.event_id,
                    )),
          );
        },
        child: Column(children: [
          Container(
            margin: EdgeInsets.only(left: 10), // Add margin
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 3,
                  blurRadius: 7,
                  offset: Offset(0, 9), // changes position of shadow
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.network(
                widget.imagePath, // Use the image URL here
                height: 190,
                width: 150,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ]));
  }
}

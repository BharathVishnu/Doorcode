import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ExpandableContainer extends StatefulWidget {
  final String text;

  const ExpandableContainer({Key? key, required this.text}) : super(key: key);

  @override
  _ExpandableContainerState createState() => _ExpandableContainerState();
}

class _ExpandableContainerState extends State<ExpandableContainer> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 25,
            ),
            Text(
              'MORE INFORMATION',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: Icon(_expanded
                  ? Icons.keyboard_arrow_up
                  : Icons.keyboard_arrow_down),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ],
        ),
        Visibility(
          visible: _expanded,
          child: Container(
            padding: EdgeInsets.only(
              left: 5,
              right: 2,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 25,
                    ),
                    Text(widget.text),
                  ],
                )
                // Display the text passed as parameter
              ],
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class Bar extends StatefulWidget implements PreferredSizeWidget {
  final String text;
  final IconData iconData;
  final Function()? onPressed;

  Bar({
    required this.text,
    required this.iconData,
    this.onPressed,
  });

  @override
  _BarState createState() => _BarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _BarState extends State<Bar> {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 6,
      child: Container(
        height: 85,
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        color: Colors.white,
        child: Row(
          children: [
            SizedBox(width: 22.0),
            Text(
              widget.text,
              style: TextStyle(color: Colors.black, fontSize: 24,fontWeight: FontWeight.bold),
            ),
            Spacer(),
            IconButton(
              icon: Icon(
                widget.iconData,
                color: Colors.black,
                size: 40,
              ),
              onPressed: widget.onPressed,
            ),
          ],
        ),
      ),
    );
  }
}

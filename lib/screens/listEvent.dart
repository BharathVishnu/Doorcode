import 'package:flutter/material.dart';

class ListEvent extends StatefulWidget {
  const ListEvent({super.key});

  @override
  State<ListEvent> createState() => _ListEventState();
}

class _ListEventState extends State<ListEvent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.only(left: 12, bottom: 8.0),
          child: Text(
            'LIST YOUR EVENT',
            style: TextStyle(color: Colors.black, fontSize: 32),
            textAlign: TextAlign.left,
          ),
        ),
        centerTitle: false,
        elevation: 8,
      ),
    );
  }
}
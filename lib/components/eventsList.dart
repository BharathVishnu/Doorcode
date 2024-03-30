import 'package:doorcode_nfc/components/clubs.dart';
import 'package:doorcode_nfc/components/standups.dart';
import 'package:flutter/material.dart';
import 'package:doorcode_nfc/components/carousel.dart';
import 'package:doorcode_nfc/components/customAppbar.dart';
import 'concerts.dart';
import 'sports.dart';

class EventsPage extends StatefulWidget {
  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  String currentPage = 'Concerts'; // Default page
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Carousel(
            onIconClicked: (page) {
              setState(() {
                currentPage = page;
              });
            },
          ),
          Expanded(
            child: Center(
              child: getPageContent(currentPage),
            ),
          ),
        ],
      ),
    );
  }

  Widget getPageContent(String page) {
    switch (page) {
      case 'Concerts':
        return Concerts();
      case 'Sports':
        return Sports();
      case 'Clubs':
        return Clubs();
      case 'Standups':
        return Standups();

      // Add more cases for other pages as needed
      default:
        return Container(); // Default empty container
    }
  }
}


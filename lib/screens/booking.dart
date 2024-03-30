import 'package:doorcode_nfc/components/artists.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:doorcode_nfc/components/viewer.dart';

class Booking extends StatelessWidget {
  final int eventId;

  const Booking({Key? key, required this.eventId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('event_info')
          .where('event_id', isEqualTo: eventId)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData) {
          return Center(child: Text('No data found'));
        }

        final event = snapshot.data!.docs.first.data()! as Map<String, dynamic>;

        return MaterialApp(
          home: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Text(
                event['event_name'],
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  size: 32,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              elevation: 2,
            ),
            body: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  Container(
                    width: 320,
                    height: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 3,
                          blurRadius: 7,
                          offset: Offset(0, 9),
                        ),
                      ],
                      image: DecorationImage(
                        image: AssetImage('assets/hestia2.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      SizedBox(width: 45),
                      Icon(Icons.calendar_today),
                      SizedBox(width: 8),
                      Text(
                        'Friday  22 MAR  2024   7.00 pm to 11.00 pm',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      SizedBox(width: 45),
                      Icon(Icons.location_on),
                      SizedBox(width: 8),
                      Text(
                        event['venue'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    ],
                  ),
                  SizedBox(height: 2),
                  Row(
                    children: [
                      SizedBox(width: 45),
                      TextButton(
                        onPressed: () {
                          _launchMapsUrl(event['venue']);
                        },
                        child: Text(
                          'VIEW ON MAP',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Divider(
                    color: Colors.black,
                    thickness: 1,
                    height: 20,
                    indent: 20,
                    endIndent: 20,
                  ),
                  SizedBox(height: 10),
                  ExpandableContainer(text: event['more_info']),
                  SizedBox(height: 10),
                  Row(children: [
                    SizedBox(
                      width: 25,
                    ),
                    Text(
                      'ARTISTS LINEUP',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    )
                  ]),
                  ScrollableCircleRow(
                      artists:
                          (event['artists'] as List<dynamic>).cast<String>()),
                ],
              ),
            ),
            bottomNavigationBar: BottomAppBar(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 5),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      event['price'].toString(),
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      // Add functionality for booking button
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 20),
                      child: Text(
                        'BOOK',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Function to launch Google Maps URL
  void _launchMapsUrl(String location) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$location';
    if (await canLaunchUrl(url as Uri)) {
      await launchUrl(url as Uri);
    } else {
      throw 'Could not launch $url';
    }
  }
}

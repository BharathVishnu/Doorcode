import 'package:doorcode_nfc/components/artists.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
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
                        '${_formatDate(event['date_from'])} to ${_formatDate(event['date_to'])}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
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
                    onPressed: () => _bookEvent(eventId),
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

  void _bookEvent(int eventId) async {
    // Fetch event information
    final eventInfoSnapshot = await FirebaseFirestore.instance
        .collection('event_info')
        .where('event_id', isEqualTo: eventId)
        .get();

    if (eventInfoSnapshot.docs.isNotEmpty) {
      final eventInfo = eventInfoSnapshot.docs.first.data();
      final venue = eventInfo['venue'] ?? '';
      final dateFrom = eventInfo['date_from'] ?? '';
      final dateTo = eventInfo['date_to'] ?? '';
      final eventName = eventInfo['event_name'] ?? '';

      // Get current user's email
      final currentUser = FirebaseAuth.instance.currentUser;
      final email = currentUser?.email ?? '';

      // Generate entry code
      final entryCode = '$eventId@$email';

      // Store ticket information to the tickets collection
      await FirebaseFirestore.instance.collection('tickets').add({
        'event_id': eventId,
        'venue': venue,
        'date_from': dateFrom,
        'date_to': dateTo,
        'event_name': eventName,
        'email': email,
        'entry_code': entryCode,
      });

      // Store event information to the validation collection
      await FirebaseFirestore.instance
          .collection('validation')
          .doc(eventId.toString())
          .set({
        'event_name': eventName,
        'event_id': eventId,
        'entry_codes': FieldValue.arrayUnion([entryCode]),
      });

      getSuccessSnackBar("Ticket Booked Successfully");
    }
  }

  getSuccessSnackBar(String message) {
    Get.snackbar(
      "Success",
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.grey,
      colorText: Colors.white,
      borderRadius: 10,
      margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
    );
  }

  String _formatDate(Timestamp? timestamp) {
    if (timestamp == null) return '';

    // Convert Timestamp to DateTime
    final date = timestamp.toDate();

    // Format the DateTime object
    final formattedDate =
        '${_getWeekday(date.weekday)} ${date.day} ${_getMonth(date.month)} ${date.year}';

    return formattedDate;
  }

  String _getWeekday(int weekday) {
    switch (weekday) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return '';
    }
  }

  String _getMonth(int month) {
    switch (month) {
      case 1:
        return 'JAN';
      case 2:
        return 'FEB';
      case 3:
        return 'MAR';
      case 4:
        return 'APR';
      case 5:
        return 'MAY';
      case 6:
        return 'JUN';
      case 7:
        return 'JUL';
      case 8:
        return 'AUG';
      case 9:
        return 'SEP';
      case 10:
        return 'OCT';
      case 11:
        return 'NOV';
      case 12:
        return 'DEC';
      default:
        return '';
    }
  }
}

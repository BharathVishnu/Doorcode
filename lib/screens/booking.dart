import 'package:doorcode_nfc/components/artists.dart';
import 'package:doorcode_nfc/components/viewer.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Booking extends StatelessWidget {
  final String heading;
  final String price;

  const Booking({
    Key? key,
    required this.heading,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            heading,
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
              SizedBox(height: 20), // Add space at the top
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
              SizedBox(height: 30,),
              Row(
                children: [
                  SizedBox(width: 45,),
                  Icon(Icons.calendar_today), // Calendar icon
                  SizedBox(width: 8), 
                  Text('Friday  22 MAR  2024   7.00 pm to 11.00 pm',
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,),), // Text
                ],
              ),
              SizedBox(height: 5,),
              Row(
                children: [
                  SizedBox(width: 45,),
                  Icon(Icons.location_on),
                  SizedBox(width: 8),
                  Text('TKMCE KARICODE KOLLAM',
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,),), // Text
                ],
              ),
              SizedBox(height: 2,),
              Row(
                children: [
                  SizedBox(width: 45,), // Location icon  
                  TextButton(
                    onPressed: () {
                      _launchMapsUrl('TKMCE KARICODE KOLLAM');
                    },
                    child: Text(
                      'VIEW ON MAP',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.blue, // Change the text color to blue
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Divider(
                color: Colors.black, // Set the color of the line
                thickness: 1, // Set the thickness of the line
                height: 20, // Set the height of the line (optional)
                indent: 20, // Set the left indent of the line (optional)
                endIndent: 20, // Set the right indent of the line (optional)
              ),
              SizedBox(height: 10,),
              ExpandableContainer(),
              SizedBox(height: 10,),
              Row(
                children:[
                  SizedBox(width: 42,),
                  Text(
                'ARTISTS LINEUP',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              )]),
              ScrollableCircleRow(),
            ],
          ),
        ),
         bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: 5,),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                price,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Spacer(), // Add space between price and button
            ElevatedButton(
              onPressed: () {
                // Add functionality for booking button
              },
              
              style: ElevatedButton.styleFrom(// Black button color
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0), // Rounded corners
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                child: Text(
                  'BOOK',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(width: 16), // Add space at the end
          ],
        ),
      ),
      ),
    );
  }

  // Function to launch Google Maps URL
  void _launchMapsUrl(String location) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$location';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

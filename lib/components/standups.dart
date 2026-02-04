import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'eventBox.dart';

class Standups extends StatelessWidget {
  const Standups({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 20.0, right: 10.0, left: 2.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('event_info').where('event_type', isEqualTo: 'standups').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            final events = snapshot.data!.docs;

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 30,
                crossAxisSpacing: 12,
                childAspectRatio: 1
              ),
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index].data() as Map<String, dynamic>;
                return MyBox(
                  event['image_url'],
                  event['event_id'], 
                  event['email'],    
                   // Assuming image_url is a field in your event document
                );
              },
            );
          },
        ),
      ),
    );
  }
}
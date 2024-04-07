import 'package:flutter/material.dart';
import 'package:doorcode_nfc/components/ticketsBox.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TicketsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentUserEmail = FirebaseAuth.instance.currentUser?.email ?? '';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.only(left: 12, bottom: 8.0),
          child: Text(
            'YOUR TICKETS',
            style: TextStyle(color: Colors.black, fontSize: 32),
            textAlign: TextAlign.left,
          ),
        ),
        centerTitle: false,
        elevation: 4,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('tickets')
            .where('email', isEqualTo: currentUserEmail)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final ticketDocs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: ticketDocs.length,
            itemBuilder: (context, index) {
              final ticketData =
                  ticketDocs[index].data() as Map<String, dynamic>;
              return Column(
                children: [
                  SizedBox(height: 20),
                  TicketsBox(
                    backgroundImagePath: 'assets/hestia2.png',
                    iconPath1: 'assets/logo.png',
                    iconPath2: 'assets/logo.png',
                    text1: ticketData['event_name'],
                    text2: _formatDate(ticketData['date_from']),
                    text3: ticketData['venue'] ?? '',
                  ),
                  SizedBox(height: 24),
                ],
              );
            },
          );
        },
      ),
    );
  }

  String _formatDate(Timestamp? timestamp) {
    if (timestamp == null) return '';

    final date = timestamp.toDate();
    return '${_getMonth(date.month)} ${date.day}';
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

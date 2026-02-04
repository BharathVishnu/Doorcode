import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nfc_manager/nfc_manager.dart';

class NFCTicketVal extends StatefulWidget {
  final int eventId;

  const NFCTicketVal({
    Key? key,
    required this.eventId,
  }) : super(key: key);

  @override
  _NFCTicketValState createState() => _NFCTicketValState();
}

class _NFCTicketValState extends State<NFCTicketVal> {
  Color color2 = Color(0xFF838383);
  Color color1 = Color(0xFFE8E6E6);
  Color color3 = Color(0xFF484747);

  String validationMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'VALIDATE  TICKET',
          style: TextStyle(fontSize: 32, color: Colors.black),
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
        elevation: 8,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('validation')
            .where('event_id', isEqualTo: widget.eventId)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          List<String> entryCodes = [];
          snapshot.data?.docs.forEach((doc) {
            entryCodes.addAll(List<String>.from(doc['entry_codes']));
          });

          return GestureDetector(
            onTap: () => _tagRead(entryCodes),
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 180),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 300,
                        height: 300,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: color1,
                        ),
                      ),
                      Container(
                        width: 230,
                        height: 230,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: color2,
                        ),
                      ),
                      Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: color3,
                        ),
                      ),
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: color3,
                        ),
                        child: Image.asset(
                          'assets/nfc.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 80),
                  GestureDetector(
                    //onTap: () => _tagRead(entryCodes),
                    child: Text(
                      'TAP YOUR PHONE',
                      style: TextStyle(color: Colors.black, fontSize: 40),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    validationMessage,
                    style: TextStyle(color: Colors.black, fontSize: 30),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _tagRead(List<String> entryCodes) async {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      validationMessage = 'Nope';
      String recordData = "";
      var ndef = Ndef.from(tag);
      if (ndef == null) {
        setState(() {
          validationMessage = 'Not Validated';
        });
      } else {
        var message = ndef.cachedMessage;
        if (message == null || message.records.isEmpty) {
          setState(() {
            validationMessage = 'Not Validated';
          });
        } else {
          for (var record in message.records) {
            Uint8List payload = record.payload;
            String text = utf8.decode(payload);
            text = text.substring(3);

            recordData += text;
          }

          if (entryCodes.contains(recordData)) {
            setState(() {
              validationMessage = 'Ticket validated';
            });
          } else {
            setState(() {
              validationMessage = 'Ticket not validated';
            });
          }
        }
      }
      NfcManager.instance.stopSession();
      //Get.defaultDialog(title: validationMessage);
      _showValidationDialog(validationMessage);
    });
  }

  void _showValidationDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(
              textAlign: TextAlign.center,
              message,
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}

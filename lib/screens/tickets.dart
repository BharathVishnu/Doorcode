import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';

class NFCTicket extends StatefulWidget {
  final String entryCode;

  NFCTicket({required this.entryCode});

  @override
  State<NFCTicket> createState() => _NFCTicketState();
}

class _NFCTicketState extends State<NFCTicket> {
  Color color2 = Color(0xFF838383);
  Color color1 = Color(0xFFE8E6E6);
  Color color3 = Color(0xFF484747);

  @override
  void initState() {
    super.initState();
    _ndefWrite(widget.entryCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'GET YOUR CODE',
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
      body: Center(
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
            Text(
              'TAP YOUR PHONE',
              style: TextStyle(color: Colors.black, fontSize: 40),
            ),
          ],
        ),
      ),
    );
  }

  void _ndefWrite(String entryCode) async {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      var ndef = Ndef.from(tag);
      if (ndef == null || !ndef.isWritable) {
        _showValidationDialog('Tag is not ndef writable');
        NfcManager.instance.stopSession();
        return;
      }

      NdefMessage message = NdefMessage([
        NdefRecord.createText(entryCode),
      ]);

      try {
        await ndef.write(message);
        _showValidationDialog('Success to "Ndef Write"');
        NfcManager.instance.stopSession();
      } catch (e) {
        _showValidationDialog('Error: $e');
        NfcManager.instance.stopSession();
        return;
      }
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
              message,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}

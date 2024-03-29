import 'package:flutter/material.dart';

class AccountInfo extends StatefulWidget {
  const AccountInfo({Key? key});

  @override
  State<AccountInfo> createState() => __AccountInfoState();
}

class __AccountInfoState extends State<AccountInfo> {
  Color color2 = Color(0xFF838383);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: 32, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 1,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color2,
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(right: 40,), // Adjust the left padding as needed
              child: Text(
                'UPCOMING EVENTS',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

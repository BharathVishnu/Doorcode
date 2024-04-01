import 'package:flutter/material.dart';

class NFCValidate extends StatelessWidget {
  Color color2 = Color(0xFF838383);
  Color color1 = Color(0xFFE8E6E6);
  Color color3 = Color(0xFF484747);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('VALIDATE TICKETS',style: TextStyle(fontSize: 32,color: Colors.black),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back,size: 32,color: Colors.black,), // Use the desired icon
          onPressed: () {

            Navigator.pop(context); 
          },
        ),
        elevation: 8,
      ),
       body: Center(
        child: Column (
          children:[
          SizedBox(height: 180,),
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
                'assets/nfc.png', // Replace 'logo.png' with your logo file
                fit: BoxFit.contain, // Fit the logo inside the container
              ),),
          ],
        ),
          SizedBox(height: 80,),
          Text('SCAN THE TICKET',style: TextStyle(color: Colors.black,fontSize: 40),)
        ]
      )
      ),
    );
  }
}
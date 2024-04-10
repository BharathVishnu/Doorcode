import 'package:doorcode_nfc/components/accountWidget.dart';
import 'package:doorcode_nfc/components/genderSelection.dart';
import 'package:flutter/material.dart';

class AccountInfo extends StatefulWidget {
  const AccountInfo({Key? key});

  @override
  State<AccountInfo> createState() => __AccountInfoState();
}

class __AccountInfoState extends State<AccountInfo> {
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.only(left: 12, bottom: 8.0),
          child: Text(
            '',
            style: TextStyle(color: Colors.black, fontSize: 32),
            textAlign: TextAlign.left,
          ),
        ),
        centerTitle: false,
        elevation: 4,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 14,),
            Center(
              child: CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 70,
                child: Icon(
                  Icons.camera,
                  color: Colors.white,
                  size: 60,
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      SizedBox(height: 20,),
                      Row(
                        children: [
                          SizedBox(width: 44,),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "PERSONAL DETAILS",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),]),
                      SizedBox(height: 2,),
                      RoundedTextField(label: "FIRST NAME", controller: nameController,onEditPressed: () =>{},),
                      SizedBox(height: 14,),
                      RoundedTextField(label: "LAST NAME", controller: nameController, onEditPressed: () =>{}),
                      SizedBox(height: 14,),
                      RoundedTextField(label: "DOB", controller: nameController, onEditPressed: () =>{}),
                      SizedBox(height: 14,),
                      GenderSelection(),
                      SizedBox(height: 14,),
                      RoundedTextField(label: "MOBILE NUMBER", controller: nameController, onEditPressed: () =>{}),
                      SizedBox(height: 14,),
                      RoundedTextField(label: "EMAIL ADDRESS", controller: nameController, onEditPressed: () =>{}),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 14,),
            Container(
                  width: screenWidth,
                  height: 50,
                  color: Colors.grey[400],
                  alignment: Alignment.center,
                  child: RichText(
                    text: TextSpan(
                      text: 'I agree to the ',
                      style: TextStyle(color: Colors.black,fontSize: 10),
                      children: [
                        TextSpan(
                          text: 'Terms & Conditions ',
                          style: TextStyle(color: Colors.red),
                        ),
                        TextSpan(
                          text: 'and ',
                          style: TextStyle(color: Colors.black),
                        ),
                        TextSpan(
                          text: 'Privacy Policy. ',
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                  ),
            ),
            SizedBox(height: 12,),
            Container(
              width: 320,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(50),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(50),
                  child: Center(
                    child: Text(
                      "SAVE CHANGES",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }
}
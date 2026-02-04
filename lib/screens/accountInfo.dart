import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doorcode_nfc/components/accountWidget.dart';
import 'package:doorcode_nfc/components/genderSelection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountInfo extends StatefulWidget {
  const AccountInfo({Key? key});

  @override
  State<AccountInfo> createState() => __AccountInfoState();
}

class __AccountInfoState extends State<AccountInfo> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  String? currentGender;

  final currentUserEmail = FirebaseAuth.instance.currentUser?.email ?? '';

  late Stream<QuerySnapshot> _userDataStream;

  @override
  void initState() {
    super.initState();
    _userDataStream = FirebaseFirestore.instance
        .collection('user')
        .where('email', isEqualTo: currentUserEmail)
        .snapshots();
    _userDataStream.listen((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        final userData = snapshot.docs.first.data() as Map<String, dynamic>;
        nameController.text = userData['name'] ?? '';
        dobController.text = userData['dob'].toString().split(' ')[0] ?? '';
        phoneController.text = userData['phone'] ?? '';
        currentGender = userData['gender'];
      }
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    dobController.dispose();
    phoneController.dispose();
    super.dispose();
  }

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
            SizedBox(
              height: 14,
            ),
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
                      SizedBox(
                        height: 20,
                      ),
                      Row(children: [
                        SizedBox(
                          width: 44,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "PERSONAL DETAILS",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ]),
                      SizedBox(
                        height: 2,
                      ),
                      RoundedTextField(
                        label: "NAME",
                        controller: nameController,
                        onEditPressed: () => {},
                      ),
                      SizedBox(
                        height: 14,
                      ),
                      RoundedTextField(
                        label: "DOB",
                        controller: dobController,
                        onEditPressed: () async {
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                          );
                          if (picked != null) {
                            dobController.text =
                                picked.toString().split(' ')[0];
                          }
                        },
                      ),
                      SizedBox(
                        height: 14,
                      ),
                      GenderSelection(
                        initialGender:
                            currentGender != null && currentGender!.isNotEmpty
                                ? currentGender
                                : null,
                        onChanged: (newValue) {
                          setState(() {
                            currentGender = newValue;
                          });
                        },
                      ),
                      SizedBox(
                        height: 14,
                      ),
                      RoundedTextField(
                        label: "MOBILE NUMBER",
                        controller: phoneController,
                        onEditPressed: () => {},
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 14,
            ),
            Container(
              width: screenWidth,
              height: 50,
              color: Colors.grey[400],
              alignment: Alignment.center,
              child: RichText(
                text: TextSpan(
                  text: 'I agree to the ',
                  style: TextStyle(color: Colors.black, fontSize: 10),
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
            SizedBox(
              height: 12,
            ),
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
                  onTap: () {
                    FirebaseFirestore.instance
                        .collection('user')
                        .where('email', isEqualTo: currentUserEmail)
                        .get()
                        .then((snapshot) {
                      if (snapshot.docs.isNotEmpty) {
                        DocumentReference docRef =
                            snapshot.docs.first.reference;
                        docRef.update({
                          'name': nameController.text,
                          'dob': dobController.text,
                          'phone': phoneController.text,
                          'gender': currentGender,
                        });
                      }
                    });
                    getSuccessSnackBar("Updated Successfully");
                  },
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
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  void getSuccessSnackBar(String message) {
    Get.snackbar(
      "Success",
      "$message\n",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.grey,
      colorText: Colors.white,
      borderRadius: 10,
      margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
    );
  }
}

import 'dart:async';
import 'package:doorcode_nfc/screens/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../screens/login.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> _user;
  bool isLoging = false;
  User? get user => _user.value;
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.authStateChanges());
    ever(_user, loginRedirect);
  }

  loginRedirect(User? user) {
    Timer(Duration(seconds: isLoging ? 0 : 2), () {
      if (user == null) {
        isLoging = false;
        update();
        Get.offAll(() => Login());
      } else {
        isLoging = true;
        update();
        Get.offAll(() => HomePage());
      }
    });
  }

  void registerUser(email, password, name, phone) async {
    try {
      isLoging = true;
      update();
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      await FirebaseFirestore.instance
          .collection('user')
          .doc(auth.currentUser!.uid)
          .set({
        'name': name,
        'email': email,
        'phone': phone,
        'dob': '',
        'gender': '',
      });

      getSuccessSnackBar("Successfully logged in as ${_user.value!.email}");
    } on FirebaseAuthException catch (e) {
      //define error
      getErrorSnackBar("Account Creating Failed", e);
    }
  }

  void login(email, password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      isLoging = true;
      update();
      getSuccessSnackBar("Successfully logged in as ${_user.value!.email}");

      //   await FirebaseFirestore.instance.collection('event_info').add({
      //   'IFSC_code': 'cnr3231',
      //   'account_holder': 'Javad',
      //   'account_no': 313234656,
      //   'artists': {'arjit',}
      //   'bank_name': 'canara',
      //   'date_from': Timestamp.fromDate(DateTime(2024, 3, 19, 21, 0, 0)),
      //   'date_to': Timestamp.fromDate(DateTime(2024, 3, 21, 21, 0, 0)),
      //   'email': 'javadshajahan2003@gmail.com',
      //   'event_id': 12345,
      //   'event_name': 'fugeniz',
      //   'event_type': 'standups',
      //   'more_info': 'edm,disco',
      //   'price': 2000,
      //   'venue':'TKM'
      // });
    } on FirebaseAuthException catch (e) {
      //define error
      getErrorSnackBar("Login Failed", e);
    }
  }

  getErrorSnackBar(String message, _) {
    Get.snackbar(
      "Error",
      "$message\n${_.message}",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.grey,
      colorText: Colors.white,
      borderRadius: 10,
      margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
    );
  }

  getErrorSnackBarNew(String message) {
    Get.snackbar(
      "Error",
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.grey,
      colorText: Colors.white,
      borderRadius: 10,
      margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
    );
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

  void signOut() async {
    await auth.signOut();
  }
}

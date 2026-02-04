import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doorcode_nfc/components/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class EventRegistrationPage extends StatefulWidget {
  @override
  _EventRegistrationPageState createState() => _EventRegistrationPageState();
}

class _EventRegistrationPageState extends State<EventRegistrationPage> {
  String _imageUrl = ''; // To store image URL
  late TextEditingController _eventNameController;
  late TextEditingController _eventTypeController;
  late TextEditingController _cityController;
  late TextEditingController _venueController;
  late TextEditingController _moreInfoController;
  late TextEditingController _artistsController;
  late TextEditingController _eventRateController;
  late TextEditingController _accountHolderNameController;
  late TextEditingController _bankNameController;
  late TextEditingController _accountNumberController;
  late TextEditingController _bankIFSCController;

  DateTime? _startDate;
  DateTime? _endDate;
  DateTime? _startTime;
  DateTime? _endTime;

  String _eventType = '';

  // Get current user email
  final _currentUser = FirebaseAuth.instance.currentUser;

  var pickedFile;

  @override
  void initState() {
    super.initState();
    _eventNameController = TextEditingController();
    _cityController = TextEditingController();
    _venueController = TextEditingController();
    _moreInfoController = TextEditingController();
    _artistsController = TextEditingController();
    _eventRateController = TextEditingController();
    _accountHolderNameController = TextEditingController();
    _bankNameController = TextEditingController();
    _accountNumberController = TextEditingController();
    _bankIFSCController = TextEditingController();
  }

  @override
  void dispose() {
    _eventNameController.dispose();
    _eventTypeController.dispose();
    _cityController.dispose();
    _venueController.dispose();
    _moreInfoController.dispose();
    _artistsController.dispose();
    _eventRateController.dispose();
    _accountHolderNameController.dispose();
    _bankNameController.dispose();
    _accountNumberController.dispose();
    _bankIFSCController.dispose();
    super.dispose();
  }

  // Function to upload image and get URL
  Future<String?> uploadImage() async {
    if (pickedFile != null) {
      final filePath = pickedFile.path;
      final fileName = basename(filePath);
      final storageRef = FirebaseStorage.instance.ref().child('images');
      final reference = storageRef.child(fileName);
      final task = reference.putFile(File(filePath));
      final snapshot = await task.whenComplete(() => null);
      final url = await snapshot.ref.getDownloadURL();
      return url;
    } else {
      return null;
    }
  }

  void resetFields() {
  _eventNameController.clear();
  _cityController.clear();
  _venueController.clear();
  _moreInfoController.clear();
  _artistsController.clear();
  _eventRateController.clear();
  _accountHolderNameController.clear();
  _bankNameController.clear();
  _accountNumberController.clear();
  _bankIFSCController.clear();
  _startDate = null;
  _endDate = null;
  _startTime = null;
  _endTime = null;
  _imageUrl = '';
  _eventType = '';
}

  // Function to handle form submission
  Future<void> submitForm() async {
    // Upload image if selected
    String? imageUrl;
    if (pickedFile != null) {
      imageUrl = await uploadImage();
    }

    // Combine the date and time values to create DateTime objects
    DateTime combinedStartDateTime = _startDate!.add(
      Duration(hours: _startTime!.hour, minutes: _startTime!.minute),
    );

    DateTime combinedEndDateTime = _endDate!.add(
      Duration(hours: _endTime!.hour, minutes: _endTime!.minute),
    );

    // Convert the DateTime objects to Timestamp objects
    Timestamp startTimestamp = Timestamp.fromDate(combinedStartDateTime);
    Timestamp endTimestamp = Timestamp.fromDate(combinedEndDateTime);

    final eventId = DateTime.now().millisecondsSinceEpoch.toString();

    final eventData = {
      'image_url': imageUrl,
      'event_name': _eventNameController.text,
      'city': _cityController.text,
      'venue': _venueController.text,
      'more_info': _moreInfoController.text,
      'artists': _artistsController.text.split('\n'),
      'price': int.parse(_eventRateController.text),
      'account_holder': _accountHolderNameController.text,
      'bank_name': _bankNameController.text,
      'account_no': _accountNumberController.text,
      'IFSC_code': _bankIFSCController.text,
      'email': _currentUser != null ? _currentUser!.email : '',
      'event_id': int.parse(eventId),
      'date_from': startTimestamp,
      'date_to': endTimestamp,
      'event_type': _eventType
    };

    try {
      await FirebaseFirestore.instance.collection('event_info').add(eventData);
      print('Event data stored successfully.');
      getSuccessSnackBar("Event added successfully");
      resetFields();
    } catch (e) {
      print('Failed to store event data: $e');
      getErrorSnackBarNew("Failed to add the event");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Your Event'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('EVENT INFO',
                  style:
                      TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
              SizedBox(height: 10.0),
              Center(
                child: GestureDetector(
                  onTap: () async {
                    final picker = ImagePicker();
                    pickedFile =
                        await picker.pickImage(source: ImageSource.gallery);
                  },
                  child: Container(
                    width: 293, // Set the width to the desired value
                    height: 150, // Set the height to the desired value
                    child: pickedFile != null
                        ? Image.file(
                            File(pickedFile.path),
                            fit: BoxFit.fill,
                          )
                        : Image.asset(
                            'assets/ADD_IMAGE.png', // Replace with your image asset
                            fit: BoxFit.fill,
                          ),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: _eventNameController,
                decoration: InputDecoration(
                  labelText: 'Event Name',
                  labelStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: InputBorder.none,
                ),
              ),
              SizedBox(height: 10.0),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Event Type',
                  labelStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: InputBorder.none,
                ),
                items: ['concerts', 'standups', 'clubs', 'sports']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    _eventType = value!;
                  });
                },
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: _cityController,
                decoration: InputDecoration(
                  labelText: 'City',
                  labelStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: InputBorder.none,
                ),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: _venueController,
                decoration: InputDecoration(
                  labelText: 'Venue',
                  labelStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: InputBorder.none,
                ),
              ),
              SizedBox(height: 10.0),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                CustomButton(
                  text: '   Select  Start  Date   ',
                  onPressed: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2022),
                      lastDate: DateTime(2025),
                    );
                    if (picked != null) {
                      setState(() {
                        _startDate = picked;
                      });
                    }
                  },
                ),
                SizedBox(width: 20.0),
                CustomButton(
                  text: '   Select  Start  Time  ',
                  onPressed: () async {
                    final TimeOfDay? picked = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (picked != null) {
                      setState(() {
                        _startTime = DateTime(
                            _startDate!.year,
                            _startDate!.month,
                            _startDate!.day,
                            picked.hour,
                            picked.minute);
                      });
                    }
                  },
                ),
              ]),
              SizedBox(height: 10.0),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                CustomButton(
                  text: '   Select   End    Date   ',
                  onPressed: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2022),
                      lastDate: DateTime(2025),
                    );
                    if (picked != null) {
                      setState(() {
                        _endDate = picked;
                      });
                    }
                  },
                ),
                SizedBox(width: 20.0),
                CustomButton(
                  text: '   Select   End    Time   ',
                  onPressed: () async {
                    final TimeOfDay? picked = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (picked != null) {
                      setState(() {
                        _endTime = DateTime(_endDate!.year, _endDate!.month,
                            _endDate!.day, picked.hour, picked.minute);
                      });
                    }
                  },
                ),
              ]),
              SizedBox(height: 10.0),
              TextFormField(
                controller: _moreInfoController,
                decoration: InputDecoration(
                  labelText: 'More Info',
                  labelStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: InputBorder.none,
                ),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: _artistsController,
                decoration: InputDecoration(
                  labelText: 'Artists',
                  labelStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: InputBorder.none,
                ),
                maxLines: null,
                onChanged: (value) {
                  // Split the input into lines and update the artists list
                  _artistsController.text = value;
                },
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: _eventRateController,
                decoration: InputDecoration(
                  labelText: 'Event Rate',
                  labelStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
              ),
              SizedBox(height: 25.0),
              Text('ACCOUNT INFO',
                  style:
                      TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
              SizedBox(height: 10.0),
              TextFormField(
                controller: _accountHolderNameController,
                decoration: InputDecoration(
                  labelText: 'Account Holder Name',
                  labelStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: InputBorder.none,
                ),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: _bankNameController,
                decoration: InputDecoration(
                  labelText: 'Bank Name',
                  labelStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: InputBorder.none,
                ),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: _accountNumberController,
                decoration: InputDecoration(
                  labelText: 'Account Number',
                  labelStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: InputBorder.none,
                ),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: _bankIFSCController,
                decoration: InputDecoration(
                  labelText: 'Bank IFSC',
                  labelStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: InputBorder.none,
                ),
              ),
              SizedBox(height: 20.0),
              Center(
                child: SizedBox(
                  width: 330,
                  height: 60,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    onPressed: () {
                      submitForm();
                    },
                    child: Text(
                      'PROCEED',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
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
}

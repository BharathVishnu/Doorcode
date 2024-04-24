// import 'package:doorcode_nfc/screens/tickets.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:local_auth/local_auth.dart';

// class AuthPage extends StatefulWidget {
//   const AuthPage({Key? key}) : super(key: key);

//   @override
//   State<AuthPage> createState() => _AuthPageState();
// }

// class _AuthPageState extends State<AuthPage> {
//   final LocalAuthentication _localAuthentication = LocalAuthentication();
//   late Future<bool> _biometricAvailability;

//   @override
//   void initState() {
//     super.initState();
//     _biometricAvailability = _checkBiometricAvailability();
//   }

//   Future<bool> _checkBiometricAvailability() async {
//     return await _localAuthentication.canCheckBiometrics;
//   }

//   Future<void> _authenticate() async {
//     try {
//       bool isAuthenticated = await _localAuthentication.authenticate(
//         localizedReason: 'Authenticate to access the app',
//          options: const AuthenticationOptions(
//           stickyAuth: true,
//           biometricOnly: false,
//         ),
//       );
//       if (isAuthenticated) {
//         // Authentication successful, proceed with app functionality
//         Get.to(NFCTicket());
//       } else {
//         // Authentication failed
//         print('Authentication failed');
//       }
//     } on PlatformException catch (e) {
//       // Platform-specific error handling
//       print('Error: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: FutureBuilder<bool>(
//           future: _biometricAvailability,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return CircularProgressIndicator();
//             } else {
//               if (snapshot.hasError) {
//                 return Text('Error: ${snapshot.error}');
//               } else if (snapshot.data == true) {
//                 return ElevatedButton(
//                   onPressed: _authenticate,
//                   child: Text('Authenticate with Fingerprint'),
//                 );
//               } else {
//                 return Text('Biometric authentication is not available on this device.');
//               }
//             }
//           },
//         ),
//       ),
//     );
//   }
// }

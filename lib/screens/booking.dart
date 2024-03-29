import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class Booking extends StatelessWidget {
  final String heading;
  final String price;

  const Booking({
    Key? key,
    required this.heading,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            heading,
            style: TextStyle(
              fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
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
          elevation: 2,
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20), // Add space at the top
              Container(
                width: 320,
                height: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: Offset(0, 9),
                    ),
                  ],
                  image: DecorationImage(
                    image: AssetImage('assets/hestia2.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),

         bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: 5,),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                price,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Spacer(), // Add space between price and button
            ElevatedButton(
              onPressed: () {
                _openCheckout(context);
              },
              
              style: ElevatedButton.styleFrom(// Black button color
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0), // Rounded corners
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                child: Text(
                  'BOOK',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(width: 16), // Add space at the end
          ],
        ),
      ),
      ),
    );
  }

  void _openCheckout(BuildContext context) {
    var options = {
      'key': 'YOUR_API_KEY',
      'amount': 1, // Amount in the smallest currency unit (e.g., paise in INR)
      'name': 'DOORCODE',
      'description': 'Event Fee',
      'prefill': {'contact': 'YOUR_CONTACT_NUMBER', 'email': 'YOUR_EMAIL'},
      'external': {
        'wallets': ['paytm'] // Other wallets supported by Razorpay
      }
    };

    try {
      final Razorpay _razorpay = Razorpay();
      _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, (PaymentSuccessResponse response) {
        // Payment success callback
        print("Payment success: ${response.paymentId}");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Payment successful')));
      });
      _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, (PaymentFailureResponse response) {
        // Payment error callback
        print("Payment error: ${response.code} - ${response.message}");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Payment failed')));
      });
      _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, (ExternalWalletResponse response) {
        // External wallet callback
        print("External wallet: ${response.walletName}");
      });

      _razorpay.open(options);
    } catch (e) {
      print("Error initiating payment: $e");
    }
  }
}

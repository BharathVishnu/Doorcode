import 'package:doorcode_nfc/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';

import '../controller/auth_controller.dart';
import '../controller/input_validators.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cnfPassController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  bool _isPasswordVisible = false; // State variable for password visibility

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.0),
              // DoorCode text
              Text(
                'DOORCODE',
                style: TextStyle(
                  fontFamily: 'BebasNeue',
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 25.0),
              // Centered logo image
              Center(
                child: Image.asset(
                  'assets/logo.png',
                  width: 100.0,
                  height: 100.0,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 20.0),
              buildTextField('NAME', false, _nameController, 'assets/profile.png', true),
              buildTextField('EMAIL', false, _emailController, 'assets/email.png', true),
              buildTextField('PHONE NO', false, _phoneController, 'assets/phone.png', true),
              buildTextField('PASSWORD', true, _passwordController, 'assets/password.png', false),
              buildTextField('CONFIRM PASSWORD', true, _cnfPassController, 'assets/password.png', false),
              SizedBox(height: 24,),
              Center(
                child: SizedBox(
                  width: 330,
                  height: 60,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.black), 
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      
                    ),
                    onPressed: () {
                      if (InputValidator.validateField("Name", _nameController.text.trim()) &&
                            InputValidator.validateField("Email", _emailController.text.trim())) {
                          if (InputValidator.validatePassword(_passwordController.text, _cnfPassController.text)) {
                            AuthController.instance
                                .registerUser(_emailController.text.trim(), _passwordController.text.trim(),_nameController.text.trim(),_phoneController.text.trim());
                          }
                        }
                    },
                    child: Text(
                      'SIGN UP',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                      ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
            Center(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'ALREADY REGISTERED? ',
                      style: TextStyle(
                        fontFamily: 'BebasNeue',
                        color: Colors.grey, // Color for "NEW HERE?"
                        fontSize: 16,
                      ),
                    ),
                    TextSpan(
                      text: 'SIGN IN',
                      style: TextStyle(
                        fontFamily: 'BebasNeue',
                        color: Colors.black, 
                        fontSize: 16,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Get.to(Login());
                        },
                    ),
                  ],
                ),
              ),
            )

            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String hintText, bool isPassword, TextEditingController controller, String logoAsset, bool lowerCase) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: Image.asset(
            logoAsset, 
            width: 20.0,
            height: 20.0,
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black,
                  width: 2.0,
                ),
              ),
            ),
            child: TextField(
              obscureText: isPassword && !_isPasswordVisible,
              controller: controller,
              onChanged: (value) {
                if (lowerCase) {
                  controller.value = TextEditingValue(
                    text: value.toLowerCase(),
                    selection: controller.selection,
                  );
                }
              },
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
                suffixIcon: isPassword
                    ? IconButton(
                        icon: Icon(
                          _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          // Toggle password visibility
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      )
                    : null,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:doorcode_nfc/screens/home_page.dart';
import 'package:flutter/material.dart'; 
import 'package:flutter/widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import '../controller/auth_controller.dart';
import 'forgot_password_page.dart';
import 'register.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _forgotEmailController = TextEditingController();
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
              SizedBox(height: 50.0),
              // Centered logo image
              Center(
                child: Image.asset(
                  'assets/logo.png',
                  width: 200.0,
                  height: 200.0,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 50.0),
              buildTextField(
                  'EMAIL', false, _emailController, 'assets/email.png', true),
              SizedBox(
                height: 30,
              ),
              buildTextField('PASSWORD', true, _passwordController,
                  'assets/password.png', false),
              SizedBox(
                height: 2,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: TextButton(
                    onPressed: () {
                      Get.to(ForgotPasswordPage());
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 24,
              ),
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
                      AuthController.instance.login(
                          _emailController.text.trim(),
                          _passwordController.text.trim());
                    },
                    child: Text(
                      'LOGIN',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'NEW HERE? ',
                        style: TextStyle(
                          fontFamily: 'BebasNeue',
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                      TextSpan(
                        text: 'REGISTER',
                        style: TextStyle(
                          fontFamily: 'BebasNeue',
                          color: Colors.black,
                          fontSize: 16,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // Navigate to the registration page
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => Register()),
                            // );
                            Get.to(Register());
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

  Widget buildTextField(String hintText, bool isPassword,
      TextEditingController controller, String logoAsset, bool lowerCase) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(32.0),
          child: Image.asset(
            logoAsset,
            width: 20.0,
            height: 20.0,
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 6.0),
            padding: EdgeInsets.symmetric(horizontal: 10.0),
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
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
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
        SizedBox(
          width: 30,
          height: 30,
        )
      ],
    );
  }
}

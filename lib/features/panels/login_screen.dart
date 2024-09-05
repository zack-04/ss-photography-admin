import 'dart:convert';

import 'package:admin_console/constants.dart';
import 'package:admin_console/main.dart';
import 'package:admin_console/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>(); // Added form key

  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      // Added form validation check
      const url =
          'https://photo.sortbe.com/Login';

      try {
        final response = await http.post(
          Uri.parse(url),
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
          },
          body: {
            'mobile': mobileController.text,
            'password': passwordController.text,
            'enc': encKey,
          },
        );

        if (response.statusCode == 200) {
          print('Response body: ${response.body}'); // Log the response

          Map<String, dynamic> responseData = jsonDecode(response.body);

          if (responseData['status'] == 'Success') {
            var userData = responseData['data'];
            if (!mounted) return;
            GoRouter.of(context).go('/users');
          } else {
            String errorMessage =
                responseData['remarks'] ?? 'Unknown error occurred';
            if (!mounted) return;
            _showErrorMessage(context, errorMessage);
          }
        } else {
          print(
              'Error Response: ${response.statusCode} ${response.reasonPhrase}');
          throw Exception('Login failed with status: ${response.statusCode}');
        }
      } catch (e) {
        print('Error = $e');
        _showErrorMessage(
            context, 'An error occurred. Please try again later.');
      }
    }
  }

  void _showErrorMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.blue.shade100,
        child: Center(
          child: Container(
            height: 500,
            width: 500,
            decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: Form(
                key: formKey, // Added Form widget
                autovalidateMode: AutovalidateMode
                    .onUserInteraction,
                child: Column(
                  children: [
                    const Text(
                      'Login Screen',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 50),
                    CustomTextfield(
                      controller: mobileController,
                      text: 'Enter Mobile Number',
                      inputFormatter: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your mobile number';
                        }
                        if (value.length != 10) {
                          return 'Mobile number must be 10 digits';
                        }
                        final RegExp regex = RegExp(r'^\d{10}$');
                        if (!regex.hasMatch(value)) {
                          return 'Enter valid mobile number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    CustomTextfield(
                      controller: passwordController,
                      text: 'Enter Password',
                      obscureText: true,
                      maxLines: 1,
                    ),
                    const SizedBox(height: 60),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 50),
                      child: MaterialButton(
                        minWidth: 300,
                        height: 50,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        onPressed: () async {
                          await login();
                        },
                        color: Colors.blue,
                        textColor: Colors.white,
                        child: const Text(
                          'Login',
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

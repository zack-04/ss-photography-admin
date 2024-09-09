import 'dart:convert';
import 'package:admin_console/constants.dart';
import 'package:admin_console/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/app_images.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  // Future<void> login() async {
  //   if (formKey.currentState!.validate()) {
  //     // Added form validation check
  //     const url = 'https://photo.sortbe.com/Login';
  //
  //     try {
  //       final response = await http.post(
  //         Uri.parse(url),
  //         headers: {
  //           'Content-Type': 'application/x-www-form-urlencoded',
  //         },
  //         body: {
  //           'mobile': mobileController.text,
  //           'password': passwordController.text,
  //           'enc': encKey,
  //         },
  //       );
  //
  //       if (response.statusCode == 200) {
  //         print('Response body: ${response.body}'); // Log the response
  //
  //         Map<String, dynamic> responseData = jsonDecode(response.body);
  //
  //         if (responseData['status'] == 'Success') {
  //           var userData = responseData['data'];
  //           if (!mounted) return;
  //           GoRouter.of(context).go('/users');
  //         } else {
  //           String errorMessage =
  //               responseData['remarks'] ?? 'Unknown error occurred';
  //           if (!mounted) return;
  //           _showErrorMessage(context, errorMessage);
  //         }
  //       } else {
  //         print(
  //             'Error Response: ${response.statusCode} ${response.reasonPhrase}');
  //         throw Exception('Login failed with status: ${response.statusCode}');
  //       }
  //     } catch (e) {
  //       print('Error = $e');
  //       _showErrorMessage(
  //           context, 'An error occurred. Please try again later.');
  //     }
  //   }
  // }

  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      const url = 'https://photo.sortbe.com/Login';

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

            // Safely extract the 'id' (creator_id) from userData
            String? creatorId =
                userData['id'] != null ? userData['id'].toString() : null;

            if (creatorId != null) {
              // Save creator ID in SharedPreferences
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setString('creator_id', creatorId);

              if (!mounted) return;
              GoRouter.of(context).go('/users');
            } else {
              _showErrorMessage(context, 'Creator ID not found.');
            }
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

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword; // Toggle visibility
    });
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
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.blue.shade100,
        child: Center(
          child: Container(
            height: 550,
            width: 550,
            decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: Form(
                key: formKey, // Added Form widget
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    Image(
                      height: h * 0.1,
                      image: const AssetImage(AppImages.logo_ss),
                      fit: BoxFit.contain,
                      alignment: Alignment.center,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Welcome Back',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Please login to continue with your account',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
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
                      obscureText: _obscurePassword, // Use the state variable
                      maxLines: 1,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: _togglePasswordVisibility,
                      ),
                    ),
                    const SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 50),
                      child: MaterialButton(
                        minWidth: w,
                        height: 50,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
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

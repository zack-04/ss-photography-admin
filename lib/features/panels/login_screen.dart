import 'dart:convert';

import 'package:admin_console/constants.dart';
import 'package:admin_console/main.dart';
import 'package:admin_console/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> login() async {
    const url = 'photo.linkwork.in/Login';

    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'enc': encKey,
          'mobile': mobileController.text,
          'password': passwordController.text,
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
      } else {
        throw Exception('Failed to load');
      }
    } catch (e) {
      print('Error = $e');
    }
    // finally {
    //   if (mounted) {
    //     setState(() {
    //       isLoading = false;
    //     });
    //   }
    // }
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
                      onPressed: () {
                        GoRouter.of(context).go('/users');
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
    );
  }
}

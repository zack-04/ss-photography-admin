import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../widgets/custom_textfield.dart';

class OtpVerification extends StatefulWidget {
  final String enc;
  final String albumId;
  final String otp; // Correct OTP passed from previous screen

  const OtpVerification({
    super.key,
    required this.enc,
    required this.albumId,
    required this.otp,
  });

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  final TextEditingController otpController =
      TextEditingController(); // User input for OTP
  final _formKey = GlobalKey<FormState>();

  Future<void> verifyOtp() async {
    if (otpController.text == widget.otp) {
      // If the user input matches the generated OTP, show success
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('OTP verified successfully!')),
      );
      // Navigate to users page or perform other actions
    } else {
      // If the input OTP is incorrect, show error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid OTP. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: w * 0.05),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: h * 0.1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: h * 0.2,
                      width: w * 0.2,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.shade200,
                      ),
                      child: Center(
                        child: Icon(Icons.security, size: h * 0.08),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: h * 0.02),
              Text(
                "Verification",
                style: TextStyle(
                  fontSize: h * 0.035,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: h * 0.02),
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: w * 0.025),
                  child: Text.rich(
                    TextSpan(
                      text: 'Enter the OTP sent via SMS to verify.',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: h * 0.1),
              Form(
                key: _formKey,
                child: CustomTextfield(
                  controller: otpController,
                  text: 'Enter OTP',
                  inputFormatter: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(4),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length != 4) {
                      return 'Please enter a valid 4-digit OTP';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: h * 0.05),
              Padding(
                padding: EdgeInsets.only(bottom: h * 0.05),
                child: MaterialButton(
                  minWidth: w,
                  height: h * 0.07,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      verifyOtp(); // Call OTP verification
                    }
                  },
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: Text(
                    'VERIFY',
                    style: TextStyle(fontSize: w * 0.022),
                  ),
                ),
              ),
              Text(
                'Didn\'t receive the verification OTP? Resend again',
                style: TextStyle(
                  fontSize: w * 0.02,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield({
    super.key,
    required this.controller,
    this.maxLines,
    required this.text,
    this.obscureText = false,
    this.validator,
    this.inputFormatter,
    this.autovalidateMode,
    this.suffixIcon,
  });
  final TextEditingController controller;
  final int? maxLines;
  final String text;
  final bool obscureText;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatter;
  final AutovalidateMode? autovalidateMode;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      //cursorHeight: 20,
      cursorColor: Colors.grey,
      obscureText: obscureText,
      validator: validator,
      autovalidateMode: autovalidateMode,
      inputFormatters: inputFormatter,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: text,
        hintStyle: GoogleFonts.inter(
            fontSize: 12.0,
            color: const Color(0xFF929292),
            fontWeight: FontWeight.w400),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Color(0xFFD4D4D4), width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Color(0xFFD4D4D4), width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Color(0xFFD4D4D4), width: 1.5),
        ),
        suffixIcon: suffixIcon,
      ),
    );
  }
}

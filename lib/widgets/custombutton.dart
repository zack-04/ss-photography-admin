import 'package:admin_console/core/app_imports.dart';
import 'package:admin_console/core/constants/c.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final double rad;
  final Color col;
  final String title;

  const CustomButton({super.key, required this.col, required this.rad, required this.title});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 35,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.rad),
          color: isHovered ? widget.col.withOpacity(0.9) : widget.col,
          boxShadow: isHovered
              ? [BoxShadow(color: widget.col.withOpacity(0.8), spreadRadius: 2)]
              : [],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ignore: prefer_const_constructors
            Icon(
              Icons.add,
              color: Colors.white,
            ),
            SizedBox(width: c.w(context)*0.005,),
            // CustomSpacers.width8,
            Text(
              widget.title,
              style: TextStyle(
                fontSize: c.h(context) * 0.02,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onHover(bool isHovering) {
    setState(() {
      isHovered = isHovering;
    });
  }
}

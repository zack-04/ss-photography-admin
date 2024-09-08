import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({
    super.key,
    required this.totalCount,
    required this.currentCount,
  });
  final int totalCount;
  final int currentCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Progress bar
        SizedBox(
          width: 150,
          height: 10,
          child: LinearProgressIndicator(
            borderRadius: BorderRadius.circular(10),
            value: currentCount / totalCount,
            backgroundColor: Colors.grey.shade400,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
          ),
        ),
        const SizedBox(width: 16),
        // Progress text
        Text(
          '$currentCount/$totalCount',
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class CustomLogo extends StatelessWidget {
  final Color iconColor;
  final String text;
  final Color textColor;

  CustomLogo({
    required this.iconColor,
    required this.text,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(Icons.account_circle, size: 80, color: iconColor),
        SizedBox(height: 10),
        Text(
          text,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ],
    );
  }
}

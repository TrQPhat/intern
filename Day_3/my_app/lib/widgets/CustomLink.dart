import 'package:flutter/material.dart';

class CustomLink extends StatelessWidget {
  final String text;
  final Color titleColor;
  final Color textColor;
  final String route;

  CustomLink({
    required this.text,
    required this.titleColor,
    required this.textColor,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Đã có tài khoản?', style: TextStyle(color: titleColor)),
        TextButton(
          onPressed: () {
            if (route == "register") {
              Navigator.pushNamed(context, "/register");
            } else if (route == "login") {
              Navigator.pop(context);
            }
          },
          child: Text(text, style: TextStyle(color: textColor)),
        ),
      ],
    );
  }
}

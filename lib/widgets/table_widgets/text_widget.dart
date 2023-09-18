import 'package:flutter/material.dart';

class Txt extends StatelessWidget {
  final double fontSize;
  final String title;
  bool isNeeded;
  bool isRequired;

  Txt({
    super.key,
    required this.fontSize,
    required this.title,
    this.isNeeded = false,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isNeeded
          ? EdgeInsets.symmetric(horizontal: 10, vertical: 20)
          : EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: Text(
        title,
        style: TextStyle(
          fontSize: fontSize,
          fontFamily: "Poppins",
          fontWeight: isRequired ? FontWeight.w900 : null,
        ),
      ),
    );
  }
}

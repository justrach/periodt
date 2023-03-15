import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final Color? color;
  final TextStyle textStyle;
  final String text;

  const CustomTextField(
    this.text, {
    Key? key,
    required this.textStyle,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text, style: textStyle);
  }
}

// Example usage:

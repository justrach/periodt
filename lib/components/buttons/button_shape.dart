import 'package:flutter/material.dart';

enum ButtonShape { normal, rounded, squircle }

class MyButton extends StatelessWidget {
  final ButtonShape shape;
  final VoidCallback onPressed;
  final String? text;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? textColor;

  MyButton({
    Key? key,
    required this.onPressed,
    this.text,
    this.icon,
    this.shape = ButtonShape.normal,
    this.backgroundColor,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use primary color if no background color is specified
    final buttonColor = backgroundColor ?? Theme.of(context).primaryColor;
    // Use white if no text color is specified
    final textColor = this.textColor ?? Colors.white;

    return TextButton(
      onPressed: onPressed,
      child: icon == null
          ? Text(text!, style: TextStyle(color: textColor))
          : Icon(icon, color: textColor),
      style: TextButton.styleFrom(
        backgroundColor: buttonColor,
        shape: _getButtonShape(shape),
      ),
    );
  }

  RoundedRectangleBorder _getButtonShape(ButtonShape shape) {
    switch (shape) {
      case ButtonShape.rounded:
        return RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        );
      case ButtonShape.squircle:
        return RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        );
      case ButtonShape.normal:
      default:
        return const RoundedRectangleBorder(

        );
    }
  }
}

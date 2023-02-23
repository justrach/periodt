import 'package:flutter/material.dart';

class CircleWithText extends StatelessWidget {
  final double radius;
  final String text;
  final Color color;

  const CircleWithText({
    Key? key,
    required this.radius,
    required this.text,
    this.color = Colors.blue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

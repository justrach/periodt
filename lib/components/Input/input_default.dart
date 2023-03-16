import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final TextEditingController? controller;

  const Input({Key? key, this.labelText, this.hintText, this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
      ),
    );
  }
}

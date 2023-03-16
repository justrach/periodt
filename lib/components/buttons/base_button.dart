import 'package:flutter/material.dart';

enum ButtonType { elevated, text, plain }

class CustomButton extends StatelessWidget {
  final ButtonType buttonType;
  final VoidCallback onPressed;
  final Widget child;
  final Color? backgroundColor;
  final TextStyle? textStyle;

  CustomButton({
    Key? key,
    required this.buttonType,
    required this.onPressed,
    required this.child,
    this.backgroundColor,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    switch (buttonType) {
      case ButtonType.elevated:
        return ElevatedButton(
          onPressed: onPressed,
          child: child,
          style: ElevatedButton.styleFrom(
            textStyle: textStyle,
            backgroundColor: backgroundColor ?? colorScheme.primary,
          ),
        );
      case ButtonType.text:
        return TextButton(
          onPressed: onPressed,
          child: child,
          style: TextButton.styleFrom(
            backgroundColor: backgroundColor,
          ),
        );
      case ButtonType.plain:
      default:
        return GestureDetector(
          onTap: onPressed,
          child: Container(
            color: backgroundColor ?? Colors.transparent,
            child: DefaultTextStyle(
              style: textStyle ?? DefaultTextStyle.of(context).style.copyWith(color: colorScheme.primary),
              child: child,
            ),
          ),
        );
    }
  }
}

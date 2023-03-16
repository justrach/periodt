import 'dart:async';
import 'package:flutter/material.dart';

class UuidDigitSpinner extends StatefulWidget {
  final String digit;
  final Duration duration;

  UuidDigitSpinner({
    Key? key,
    required this.digit,
    this.duration = const Duration(milliseconds: 500),
  }) : super(key: key);

  @override
  _UuidDigitSpinnerState createState() => _UuidDigitSpinnerState();
}

class _UuidDigitSpinnerState extends State<UuidDigitSpinner>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);

    Timer(widget.duration, () {
      setState(() {
        _visible = true;
      });
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: widget.duration,
      child: _visible
          ? Text(
        widget.digit,
        style: const TextStyle(color: Colors.black),
        key: ValueKey<String>(widget.digit),
      )
          : RotationTransition(
        turns: _animation,
        child: Text(
          widget.digit,
          style: const TextStyle(color: Colors.black),
          key: ValueKey<String>('spinner-${widget.digit}'),
        ),
      ),
    );
  }
}

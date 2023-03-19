import 'dart:math';

import 'package:flutter/material.dart';

Route slideTransitionBuilder(RouteSettings settings, WidgetBuilder builder) {
  return PageRouteBuilder(
    settings: settings,
    pageBuilder: (context, animation, secondaryAnimation) => builder(context),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final offsetAnimation = Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      ).animate(animation);

      return SlideTransition(
        position: offsetAnimation,
        child: GestureDetector(
          onHorizontalDragEnd: (dragEndDetails) {
            if (dragEndDetails.primaryVelocity! > 0) {
              Navigator.of(context).pop();
            }
          },
          child: child,
        ),
      );
    },
  );
}

Route radialTransitionBuilder(RouteSettings settings, WidgetBuilder builder) {
  return PageRouteBuilder(
    settings: settings,
    pageBuilder: (context, animation, secondaryAnimation) => builder(context),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final scaleAnimation = Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(animation);

      return ScaleTransition(
        scale: scaleAnimation,
        child: GestureDetector(
          onHorizontalDragEnd: (dragEndDetails) {
            if (dragEndDetails.primaryVelocity! > 0) {
              Navigator.of(context).pop();
            }
          },
          child: child,
        ),
      );
    },
  );
}
Route radialRevealTransitionBuilder(RouteSettings settings, WidgetBuilder builder) {
  return PageRouteBuilder(
    settings: settings,
    transitionDuration: const Duration(milliseconds: 1000),
    pageBuilder: (context, animation, secondaryAnimation) => builder(context),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final progress = Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(animation);

      return GestureDetector(
        onHorizontalDragEnd: (dragEndDetails) {
          if (dragEndDetails.primaryVelocity! > 0) {
            Navigator.of(context).pop();
          }
        },
        child: AnimatedBuilder(
          animation: progress,
          builder: (context, _) {
            final screenSize = MediaQuery.of(context).size;
            final maxRadius = sqrt(pow(screenSize.width, 2) + pow(screenSize.height, 2));

            return ClipOval(
              clipper: CircleClipper(
                progress: progress.value,
                maxRadius: maxRadius,
              ),
              child: child,
            );
          },
        ),
      );
    },
  );
}


class CircleClipper extends CustomClipper<Rect> {
  final double progress;
  final double maxRadius;

  CircleClipper({required this.progress, required this.maxRadius});

  @override
  Rect getClip(Size size) {
    final radius = maxRadius * progress;
    final diameter = 2 * radius;
    return Rect.fromLTWH(
      size.width / 2 - radius,
      size.height / 2 - radius,
      diameter,
      diameter,
    );
  }

  @override
  bool shouldReclip(CircleClipper oldClipper) {
    return progress != oldClipper.progress || maxRadius != oldClipper.maxRadius;
  }
}

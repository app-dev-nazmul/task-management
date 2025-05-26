import 'package:flutter/material.dart';

class GradientBackgroundWrapper extends StatelessWidget {
  final Widget child;

  const GradientBackgroundWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFF8F8FB), // White
            Color(0xFFC7D2EF), // Light gray-blue
          ],
        ),
      ),
      child: child,
    );
  }
}
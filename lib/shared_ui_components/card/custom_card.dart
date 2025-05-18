import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final double elevation;

  const CustomCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.elevation = 4,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: padding,
        child: child,
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final double radius;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color = Colors.blue,
    this.radius = 12,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}

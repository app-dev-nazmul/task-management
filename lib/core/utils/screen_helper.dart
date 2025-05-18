import 'package:flutter/material.dart';

class ScreenHelper {
  static double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
  static double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;
  static Orientation orientation(BuildContext context) => MediaQuery.of(context).orientation;

  static bool isMobile(BuildContext context) => screenWidth(context) < 600;
  static bool isTablet(BuildContext context) => screenWidth(context) >= 600 && screenWidth(context) < 1024;
  static bool isDesktop(BuildContext context) => screenWidth(context) >= 1024;
}

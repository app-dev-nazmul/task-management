import 'package:flutter/material.dart';

class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, BoxConstraints constraints, DeviceScreenType deviceType) builder;

  const ResponsiveBuilder({required this.builder, super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final deviceType = width >= 1024
            ? DeviceScreenType.desktop
            : width >= 600
            ? DeviceScreenType.tablet
            : DeviceScreenType.mobile;
        return builder(context, constraints, deviceType);
      },
    );
  }
}

enum DeviceScreenType { mobile, tablet, desktop }

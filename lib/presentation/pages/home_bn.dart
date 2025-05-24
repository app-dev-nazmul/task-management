import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hifzpro/presentation/controller/theme_controller.dart';
import 'package:hifzpro/presentation/provider/theme_provider.dart';
import 'package:hifzpro/shared_ui_components/appbars/custom_appbar.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../l10n/app_localizations.dart';

class HomeBn extends ConsumerWidget {
  const HomeBn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;


    bool isMobile = ResponsiveBreakpoints.of(context).isMobile;
    bool isTablet = ResponsiveBreakpoints.of(context).isTablet;
    bool isDesktop = ResponsiveBreakpoints.of(context).isDesktop;

    return Scaffold(
      appBar: CustomAppbar(
        leading: Icon(Icons.grid_view_rounded),
        // title: localizations.appName.toString(),
        title: "Bangla",
        actions: [IconButton(onPressed: () {
          ref.read(themeControllerProvider.notifier).toggleTheme();
        }, icon: Icon(Icons.light_mode))],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                localizations.greetings, // 👈 Localized Greeting
                style: TextStyle(
                  fontSize:
                      isMobile
                          ? 20
                          : isTablet
                          ? 28
                          : 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                width: isMobile ? double.infinity : 500,
                child: Text(
                  'This is a responsive card.\n\n'
                  'Current device type: ${isMobile
                      ? 'Mobile'
                      : isTablet
                      ? 'Tablet'
                      : 'Desktop'}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isMobile ? 16 : 20,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Example Button',
                  style: TextStyle(fontSize: isMobile ? 14 : 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

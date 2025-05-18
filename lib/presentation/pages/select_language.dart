
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../routes/app_router.dart';
import '../../routes/app_routes.dart';
import '../provider/language_provider.dart';

class SelectLanguage extends ConsumerWidget {
  const SelectLanguage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void changeLang(String code) {
      ref.read(languageControllerProvider.notifier).changeLanguage(Locale(code));
      // Navigator.pushReplacementNamed(context, AppRoutes.home);
      AppRouter.router.push(AppRoutes.home);
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.flutter_dash, size: 100, color: Colors.blue),
            const SizedBox(height: 20),
            const Text(
              'Select Language',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => changeLang('en'),
              child: const Text('English'),
            ),
            ElevatedButton(
              onPressed: () => changeLang('bn'),
              child: const Text('বাংলা'),
            ),
            ElevatedButton(
              onPressed: () => changeLang('id'),
              child: const Text('Bahasa Indonesia'),
            ),
          ],
        ),
      ),
    );
  }
}

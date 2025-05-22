import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../l10n/app_localizations.dart';
import '../../routes/app_router.dart';
import '../../routes/app_routes.dart';
import '../provider/language_provider.dart';


class SelectLanguage extends ConsumerWidget {
  const SelectLanguage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    void changeLang(String code) {
      ref.read(languageControllerProvider.notifier).changeLanguage(Locale(code));
      AppRouter.router.push(AppRoutes.home);
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.flutter_dash, size: 100, color: Colors.blue),
            const SizedBox(height: 20),
             Text(
              loc.selectLanguage,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => changeLang('en'),
              child:  Text(loc.english),
            ),
            ElevatedButton(
              onPressed: () => changeLang('bn'),
              child:  Text(loc.bangla),
            ),
            ElevatedButton(
              onPressed: () => changeLang('id'),
              child:  Text(loc.indonesian),
            ),
          ],
        ),
      ),
    );
  }
}

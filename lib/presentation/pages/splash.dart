import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hifzpro/constants/supported_locales.dart';
import 'package:hifzpro/l10n/app_localizations.dart';
import 'package:hifzpro/l10n/app_localizations_bn.dart';
import '../../generated/assets.dart';
import '../../routes/app_routes.dart';
import '../../routes/app_router.dart';
import '../provider/language_provider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  static const Duration _splashDelay = Duration(seconds: 2);
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_)=> _checkLanguage());
    _checkLanguage();
  }

  Future<void> _checkLanguage() async {
    await Future.delayed(_splashDelay); // Optional splash delay
    final result = await ref.read(hasLanguageSelectedProvider.future);
    if (!mounted) return;
      if (result) {
        final locale = Localizations.localeOf(context);
        if (locale.languageCode==AppConstants.defaultLanguageCode) {
          AppRouter.router.go(AppRoutes.home);
        } else {
          AppRouter.router.go(AppRoutes.homeBn);
        }
      } else {
        AppRouter.router.go(AppRoutes.language);
      }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(Assets.imagesAppLogo, width: 150, height: 150),
            const SizedBox(height: 20),
            Text(
              loc.appName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 23,
                color: Theme.of(context).secondaryHeaderColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../routes/app_routes.dart';
import '../../routes/app_router.dart';
import '../provider/language_provider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLanguage();
  }

  Future<void> _checkLanguage() async {
    await Future.delayed(const Duration(seconds: 5)); // Optional splash delay
    final result = await ref.read(hasLanguageSelectedProvider.future);

    if (mounted) {
      if (result) {
        AppRouter.router.go(AppRoutes.home);
      } else {
        AppRouter.router.go(AppRoutes.language);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: FlutterLogo(size: 100), // Customize with your brand
      ),
    );
  }
}
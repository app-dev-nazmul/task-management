import 'package:flutter/material.dart';
import 'package:hifzpro/presentation/pages/home_bn.dart';
import '../../presentation/pages/home.dart';
import '../presentation/pages/select_language.dart';
import '../presentation/pages/splash.dart';
import 'app_routes.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter _router = GoRouter(
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.home,
        name: 'home',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: AppRoutes.homeBn,
        name: 'homeBn',
        builder: (context, state) => const HomeBn(),
      ),
      GoRoute(
        path: AppRoutes.language,
        name: 'language',
        builder: (context, state) => const SelectLanguage(),
      ),
    ],
    errorBuilder:
        (context, state) =>
            const Scaffold(body: Center(child: Text('Page not found'))),
  );

  static GoRouter get router => _router;
}

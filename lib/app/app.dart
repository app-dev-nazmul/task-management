import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hifzpro/constants/supported_locales.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../di/di.dart';
import '../l10n/app_localizations.dart';
import '../presentation/provider/language_provider.dart';
import '../routes/app_router.dart';
import '../themes/app_theme.dart';
import '../presentation/controller/theme_controller.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<Widget> initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  return const ProviderScope(child: MyApp());
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(themeControllerProvider);
    final currentLocale = ref.watch(languageControllerProvider);


    final isDarkMode = currentTheme == AppTheme.dark;

    final systemUiOverlayStyle =
    isDarkMode ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark;

    SystemChrome.setSystemUIOverlayStyle(
      systemUiOverlayStyle.copyWith(statusBarColor: Colors.transparent),
    );

    return MaterialApp.router(
      title: AppLocalizations.of(context)?.appName,
      debugShowCheckedModeBanner: false,
      theme: appThemeData[AppTheme.light],
      darkTheme: appThemeData[AppTheme.dark],
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      locale: currentLocale,
      routerConfig: AppRouter.router,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppConstants.supportedLocales,
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: ScrollConfiguration(
          behavior: const _GlobalScrollBehavior(),
          child: child!,
        ),
        breakpoints: const [
          Breakpoint(start: 0, end: 450, name: MOBILE),
          Breakpoint(start: 451, end: 800, name: TABLET),
          Breakpoint(start: 801, end: 1920, name: DESKTOP),
          Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
    );
  }
}

class _GlobalScrollBehavior extends ScrollBehavior {
  const _GlobalScrollBehavior();

  @override
  ScrollPhysics getScrollPhysics(_) => const BouncingScrollPhysics();
}

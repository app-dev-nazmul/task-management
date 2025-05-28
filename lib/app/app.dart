import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../di/di.dart';
import '../routes/app_router.dart';
import '../themes/gradient_background_wrapper.dart';
import '../themes/theme.dart';

Future<Widget> initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  return const ProviderScope(child: MyApp());
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.light,
          theme: appThemeData[AppTheme.light],
          routerConfig: AppRouter.router,
          builder: (context, child) => ScrollConfiguration(
            behavior: const _GlobalScrollBehavior(),
            child: GradientBackgroundWrapper(
              child: child!,
            ),
          ),
        );
      },
    );
  }
}

class _GlobalScrollBehavior extends ScrollBehavior {
  const _GlobalScrollBehavior();

  @override
  ScrollPhysics getScrollPhysics(_) => const BouncingScrollPhysics();
}
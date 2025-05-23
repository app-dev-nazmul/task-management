import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../di/di.dart';
import '../../domain/repositories/user_repository.dart';
import '../../themes/app_theme.dart';
import '../controller/theme_controller.dart';

final themeControllerProvider = StateNotifierProvider<ThemeController, AppTheme>((ref){
  return ThemeController(getIt<UserRepository>());
});

final isDarkModeController = Provider<bool>((ref){
  final theme = ref.watch(themeControllerProvider);
  return theme == AppTheme.dark;
});
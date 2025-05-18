import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../themes/app_theme.dart';

class ThemeController extends StateNotifier<AppTheme> {
  ThemeController() : super(AppTheme.light);

  ThemeData get themeData => appThemeData[state]!;

  bool get isDarkMode => state == AppTheme.dark;

  void toggleTheme() {
    state = state == AppTheme.light ? AppTheme.dark : AppTheme.light;
  }
}
final themeControllerProvider =
    StateNotifierProvider<ThemeController, AppTheme>((ref) {
      return ThemeController();
    });

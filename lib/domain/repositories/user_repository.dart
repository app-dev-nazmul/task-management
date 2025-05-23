import 'package:flutter/material.dart';
import 'package:hifzpro/themes/app_theme.dart';

abstract class UserRepository {
 Future<void> setUserLanguage(String lang);
 Future<String?> getUserLanguage();
 Future<void> setTheme(AppTheme theme);
 Future<AppTheme?> getTheme();
}

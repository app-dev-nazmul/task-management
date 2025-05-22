import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hifzpro/constants/supported_locales.dart';
import '../../domain/repositories/user_repository.dart';

class LanguageController extends StateNotifier<Locale> {
  final UserRepository _userRepository;

  LanguageController(this._userRepository) : super(Locale(AppConstants.defaultLanguageCode)) {
    _loadSavedLanguage();
  }

  Future<void> _loadSavedLanguage() async {
    final lang = await _userRepository.getUserLanguage();
    if (lang != null) {
      state = Locale(lang);
    }
  }

  Future<void> changeLanguage(Locale locale) async {
    state = locale;
    await _userRepository.setUserLanguage(locale.languageCode);
  }
}
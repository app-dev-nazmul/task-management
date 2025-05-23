import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/repositories/user_repository.dart';
import '../../themes/app_theme.dart';

class ThemeController extends StateNotifier<AppTheme> {
  final UserRepository _userRepository;

  ThemeController(this._userRepository) : super(AppTheme.light){
    loadTheme();
  }

  Future<void> loadTheme() async {
    final storedTheme = await _userRepository.getTheme();
    if (storedTheme != null) {
      state = storedTheme;
    }
  }

 Future <void> toggleTheme() async {
    state =  state == AppTheme.light ? AppTheme.dark : AppTheme.light;
    await _userRepository.setTheme(state);
  }
}

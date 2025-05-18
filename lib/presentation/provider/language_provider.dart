import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hifzpro/presentation/controller/language_controller.dart';
import '../../domain/repositories/user_repository.dart';
import '../../di/di.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return getIt<UserRepository>();
});

final languageControllerProvider =
StateNotifierProvider<LanguageController, Locale>((ref) {
  final userRepo = ref.watch(userRepositoryProvider);
  return LanguageController(userRepo);
});

final hasLanguageSelectedProvider = FutureProvider<bool>((ref) async {
  final languageRepo = ref.watch(userRepositoryProvider);
  final lang = await languageRepo.getUserLanguage();
  return lang != null;
});

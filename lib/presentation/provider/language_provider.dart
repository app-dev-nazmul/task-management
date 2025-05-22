import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hifzpro/presentation/controller/language_controller.dart';
import '../../domain/repositories/user_repository.dart';
import '../../di/di.dart';

// Provide UserRepository using GetIt (registered via injectable)
final userRepositoryProvider = Provider<UserRepository>(
  (ref) => getIt<UserRepository>(),
);

// LanguageController uses the above provider — this is the clean way
final languageControllerProvider =
    StateNotifierProvider<LanguageController, Locale>(
      (ref) => LanguageController(ref.watch(userRepositoryProvider)),
    );

// Checks if language is selected (used for onboarding flow)
final hasLanguageSelectedProvider = FutureProvider<bool>((ref) async {
  final languageRepo = ref.watch(userRepositoryProvider);
  final lang = await languageRepo.getUserLanguage();
  return lang != null;
});

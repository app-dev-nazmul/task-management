import 'package:electrical_tools/core/service/api_service.dart';
import 'package:electrical_tools/data/models/storage_key.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

import '../../core/service/shared_prefs_service.dart';
import '../../domain/repositories/user_repository.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  SharedPrefsService _sp;

  UserRepositoryImpl(this._sp);

  @override
  Future<String?> getUserLanguage() async {
    try {
      return await _sp.read(StorageKey.language); // can return null
    } catch (e, stackTrace) {
      debugPrint('Error getting language: $e');
      debugPrintStack(stackTrace: stackTrace);
      return null;
    }
  }

  @override
  Future<void> setUserLanguage(String lang) async {
    // TODO: implement setUserLanguage
    try {
      await _sp.write(lang, StorageKey.language);
    } catch (e, stackTrace) {
      debugPrint('Error saving language: $e');
      debugPrintStack(stackTrace: stackTrace);
    }
  }
}

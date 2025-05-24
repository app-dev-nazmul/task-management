import 'package:flutter/cupertino.dart';
import 'package:hifzpro/data/models/storage_key.dart';
import 'package:hifzpro/themes/app_theme.dart';
import 'package:injectable/injectable.dart';

import '../../core/service/shared_prefs_service.dart';
import '../../domain/repositories/user_repository.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final SharedPrefsService _sp;

  UserRepositoryImpl(this._sp);

  @override
  Future<String?> getUserLanguage() async {
    try {
      return await _sp.read(StorageKey.language); // can return null
    } catch (e, stackTrace) {
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

  @override
  Future<AppTheme?> getTheme() async{
    // TODO: implement getTheme
   try{
     final data = await _sp.read(StorageKey.theme);
     return AppTheme.values.byName(data);
   }catch(e){
     return null;
   }
  }

  @override
  Future<void> setTheme(AppTheme theme) async {
    // TODO: implement setTheme
    try{
      await _sp.write(theme.name,StorageKey.theme);
    }catch(e,stackTrace){
      debugPrintStack(stackTrace: stackTrace);
    }
  }
}

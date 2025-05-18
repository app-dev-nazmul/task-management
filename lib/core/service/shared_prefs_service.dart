import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/storage_key.dart';

abstract interface class SharedPrefsService {
  Future<void> write<T>(T value, StorageKey key);
  Future<T?> read<T>(StorageKey key);

  Future<void> writeCustom<T>(T value, String key);
  Future<T?> readCustom<T>(String key);

  Future<void> writeStringList(List<String> value, StorageKey key);
  Future<List<String>?> readStringList(StorageKey key);

  Future<void> writeJson(Map<String, dynamic> json, String key);
  Future<Map<String, dynamic>?> readJson(String key);

  Future<void> delete(StorageKey key);
  Future<void> deleteCustom(String key);

  Future<void> clearAll();
}

@LazySingleton(as: SharedPrefsService)
class SharedPrefsServiceImpl implements SharedPrefsService {
  final SharedPreferences _sp;

  SharedPrefsServiceImpl(this._sp);

  @override
  Future<void> write<T>(T value, StorageKey key) async {
    await _write(value, key.name);
  }

  @override
  Future<T?> read<T>(StorageKey key) async {
    final dynamic value = _sp.get(key.name);
    if (value is T) return value;
    return null;
  }

  @override
  Future<void> writeCustom<T>(T value, String key) async {
    await _write(value, key);
  }

  @override
  Future<T?> readCustom<T>(String key) async {
    final dynamic value = _sp.get(key);
    if (value is T) return value;
    return null;
  }

  @override
  Future<void> writeStringList(List<String> value, StorageKey key) async {
    await _sp.setStringList(key.name, value);
  }

  @override
  Future<List<String>?> readStringList(StorageKey key) async {
    return _sp.getStringList(key.name);
  }

  @override
  Future<void> writeJson(Map<String, dynamic> json, String key) async {
    await _sp.setString(key, jsonEncode(json));
  }

  @override
  Future<Map<String, dynamic>?> readJson(String key) async {
    final jsonString = _sp.getString(key);
    if (jsonString != null) {
      return jsonDecode(jsonString) as Map<String, dynamic>;
    }
    return null;
  }

  @override
  Future<void> delete(StorageKey key) async {
    await _sp.remove(key.name);
  }

  @override
  Future<void> deleteCustom(String key) async {
    await _sp.remove(key);
  }

  @override
  Future<void> clearAll() async {
    await _sp.clear();
  }

  // Reusable private method
  Future<void> _write<T>(T value, String key) async {
    switch (value.runtimeType) {
      case int:
        await _sp.setInt(key, value as int);
        break;
      case String:
        await _sp.setString(key, value as String);
        break;
      case bool:
        await _sp.setBool(key, value as bool);
        break;
      case double:
        await _sp.setDouble(key, value as double);
        break;
      default:
        throw ArgumentError('Unsupported type: ${value.runtimeType}');
    }
  }
}

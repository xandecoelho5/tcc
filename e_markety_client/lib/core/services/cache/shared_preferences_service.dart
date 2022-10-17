import 'package:e_markety_client/core/services/cache/cache_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService implements ICacheService {
  SharedPreferences? _sharedPreferences;

  SharedPreferencesService() {
    _ensureInit();
  }

  Future<void> _ensureInit() async {
    _sharedPreferences ??= await Modular.getAsync<SharedPreferences>();
  }

  @override
  Future<Object?> get(String key) async {
    await _ensureInit();
    return _sharedPreferences!.get(key);
  }

  @override
  Future<void> remove(String key) async {
    await _ensureInit();
    await _sharedPreferences!.remove(key);
  }

  @override
  Future<void> set(String key, dynamic value) async {
    await _ensureInit();
    if (value is String) {
      await _sharedPreferences!.setString(key, value);
    } else if (value is int) {
      await _sharedPreferences!.setInt(key, value);
    } else if (value is double) {
      await _sharedPreferences!.setDouble(key, value);
    } else if (value is bool) {
      await _sharedPreferences!.setBool(key, value);
    } else if (value is List<String>) {
      await _sharedPreferences!.setStringList(key, value);
    }
  }
}

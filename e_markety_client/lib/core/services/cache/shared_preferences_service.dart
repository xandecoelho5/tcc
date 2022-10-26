import 'package:e_markety_client/core/services/cache/cache_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService implements ICacheService {
  SharedPreferencesService() {
    _ensureInit();
  }

  late SharedPreferences _plugin;

  Future<void> _ensureInit() async {
    _plugin = await Modular.getAsync<SharedPreferences>();
  }

  @override
  Future<dynamic> get(String key) async {
    await _ensureInit();
    return _plugin.get(key);
  }

  @override
  Future<void> delete(String key) async {
    await _ensureInit();
    await _plugin.remove(key);
  }

  @override
  Future<void> save(String key, dynamic value) async {
    await _ensureInit();
    if (value is String) {
      await _plugin.setString(key, value);
    } else if (value is int) {
      await _plugin.setInt(key, value);
    } else if (value is double) {
      await _plugin.setDouble(key, value);
    } else if (value is bool) {
      await _plugin.setBool(key, value);
    } else if (value is List<String>) {
      await _plugin.setStringList(key, value);
    } else {
      print('not saved on Shared Preference');
    }
  }

  @override
  Stream<List> getStream(String key) {
    // TODO: implement getStream
    throw UnimplementedError();
  }
}

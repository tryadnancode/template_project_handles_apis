import 'package:shared_preferences/shared_preferences.dart';
import 'storage_service.dart';

class SharedPreferencesStorageService implements StorageService {
  late final SharedPreferences _prefs;

  @override
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  String? get(String key) {
    return _prefs.getString(key);
  }

  @override
  Future<void> set(String key, String value) async {
    await _prefs.setString(key, value);
  }

  @override
  Future<void> remove(String key) async {
    await _prefs.remove(key);
  }

  @override
  Future<void> clear() async {
    await _prefs.clear();
  }
}

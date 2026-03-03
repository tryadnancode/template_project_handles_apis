abstract class StorageService {
  Future<void> init();

  Future<void> set(String key, String value);

  String? get(String key);

  Future<void> remove(String key);

  Future<void> clear();
}

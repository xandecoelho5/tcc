abstract class ICacheService {
  Future<void> set(String key, dynamic value);

  Future<Object?> get(String key);

  Future<void> remove(String key);
}

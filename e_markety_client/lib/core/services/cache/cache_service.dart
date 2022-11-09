abstract class ICacheService {
  Future<void> save(String key, dynamic value);

  Future<dynamic> get(String key);

  Future<void> delete(String key);
}

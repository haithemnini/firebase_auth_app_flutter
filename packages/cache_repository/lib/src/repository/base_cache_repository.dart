abstract class BaseCacheRepository {
  /// The [user] stream is used to get the user.
  Future<void> saveUser(String email, String password, bool isRemember);

  Future<Map<String, String>> getUser();

  Future<void> setChekRemember(bool isRemember);

  Future<bool> getChekRemember();

  /// The [user] stream is used to get the user.
  Future<void> deleteUser();
}

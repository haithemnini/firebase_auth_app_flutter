import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'base_cache_repository.dart';

/// The [CashRepository] class...

class CashRepository implements BaseCacheRepository {
  /// The [CashRepository] constructor...
  CashRepository([
    FlutterSecureStorage? secureStorage,
  ]) : _secureStorage = secureStorage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _secureStorage;

  final _userCacheEmailKey = '__user_cache_Email_key__';
  final _userCachePasswordKey = '__user_cache_Password_key__';
  final _userCacheRememberKey = '__user_cache_Remember_key__';

  /// The [getUser] method...
  @override
  Future<Map<String, String>> getUser() async {
    final String? email = await _secureStorage.read(key: _userCacheEmailKey);
    final String? password = await _secureStorage.read(
      key: _userCachePasswordKey,
    );

    return {
      'email': email ?? '',
      'password': password ?? '',
    };
  }

  /// The [getChekRemember] method...
  @override
  Future<bool> getChekRemember() async {
    final String? remember = await _secureStorage.read(
      key: _userCacheRememberKey,
    );
    return remember == 'true';
  }

  /// The [saveUser] method...
  @override
  Future<void> saveUser(String email, String password, bool isRemember) async {
    await _secureStorage.write(key: _userCacheEmailKey, value: email);
    await _secureStorage.write(key: _userCachePasswordKey, value: password);
  }

  /// The [setChekRemember] method...
  @override
  Future<void> setChekRemember(bool isRemember) async {
    await _secureStorage.write(
      key: _userCacheRememberKey,
      value: isRemember.toString(),
    );
  }

  /// The [deleteUser] method...
  @override
  Future<void> deleteUser() {
    return Future.wait([
      _secureStorage.delete(key: _userCacheRememberKey),
      _secureStorage.delete(key: _userCacheEmailKey),
      _secureStorage.delete(key: _userCachePasswordKey),
    ]);
  }
}

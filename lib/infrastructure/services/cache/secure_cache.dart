import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_ce/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'cache_service.dart';

part 'secure_cache.g.dart';

class SecureCache {
  final Box _box;
  final FlutterSecureStorage _secureStorage;
  var _token = '';

  SecureCache(this._box, this._secureStorage);

  Future<String> get token async {
    if (_token.isNotEmpty) return _token;
    if (_box.get('has_token', defaultValue: false)) {
      _token = await _secureStorage.read(key: 'token') ?? '';
    }
    return _token;
  }

  Future<void> setToken(String token) async {
    await _box.put('has_token', true);
    await _secureStorage.write(key: 'token', value: token);
  }

  Future<void> clear() async {
    await _box.clear();
    await _secureStorage.deleteAll();
  }
}

@Riverpod(keepAlive: true)
Future<SecureCache> secureCache(Ref ref) async {
  final cacheService = await ref.watch(cacheServiceProvider.future);
  return SecureCache(cacheService.appBox, ref.watch(_secureStorageProvider));
}

@Riverpod(keepAlive: true)
FlutterSecureStorage _secureStorage(Ref ref) {
  return const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );
}

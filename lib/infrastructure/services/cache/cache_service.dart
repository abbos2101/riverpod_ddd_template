import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cache_service.g.dart';

class CacheService {
  late Box _appBox;
  late Box _secureBox;
  var _isInitialized = false;

  Future<void> init() async {
    if (kIsWeb) {
      Hive.init('/');
    } else {
      Hive.init((await getTemporaryDirectory()).path);
    }

    _appBox = await Hive.openBox('app');
    _secureBox = await Hive.openBox('secure');
    _isInitialized = true;
  }

  Box get appBox => _appBox;

  Box get secureBox => _secureBox;

  bool get isInitialized => _isInitialized;
}

@Riverpod(keepAlive: true)
Future<CacheService> cacheService(Ref ref) async {
  final service = CacheService();
  await service.init();
  return service;
}

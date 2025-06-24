import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'cache_service.dart';

part 'app_cache.g.dart';

class AppCache {
  final Box _box;

  AppCache(this._box);

  String get locale => _box.get('locale') ?? '';

  Future<void> setLocale(String locale) => _box.put('locale', locale);

  String get theme => _box.get('theme') ?? '';

  Future<void> setTheme(String theme) => _box.put('theme', theme);
}

@Riverpod(keepAlive: true)
Future<AppCache> appCache(Ref ref) async {
  final cacheService = await ref.watch(cacheServiceProvider.future);
  return AppCache(cacheService.appBox);
}

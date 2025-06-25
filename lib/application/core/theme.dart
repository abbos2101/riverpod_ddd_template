import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_ddd_template/infrastructure/services/cache/app_cache.dart';

part 'theme.g.dart';

@riverpod
class Theme extends _$Theme {
  @override
  Future<ThemeMode> build() async {
    final appCache = await ref.watch(appCacheProvider.future);

    switch (appCache.theme) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  Future<void> changeTheme(ThemeMode mode) async {
    final appCache = await ref.read(appCacheProvider.future);

    await appCache.setTheme(mode.name);
    state = AsyncData(mode);
  }
}

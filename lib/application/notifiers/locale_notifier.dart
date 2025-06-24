import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_ddd_template/infrastructure/services/cache/app_cache.dart';

part 'locale_notifier.g.dart';

@riverpod
class LocaleNotifier extends _$LocaleNotifier {
  @override
  Future<Locale> build() async {
    final appCache = await ref.watch(appCacheProvider.future);
    final savedLocale = appCache.locale;

    if (savedLocale.isNotEmpty) {
      final parts = savedLocale.split('-');
      if (parts.length == 2) {
        return Locale(parts[0], parts[1]);
      }
      return Locale(savedLocale);
    }

    return const Locale('uz', 'UZ');
  }

  Future<void> changeLocale(BuildContext context, Locale locale) async {
    final appCache = await ref.read(appCacheProvider.future);
    final localeString = locale.countryCode != null
        ? '${locale.languageCode}-${locale.countryCode}'
        : locale.languageCode;

    await appCache.setLocale(localeString);
    await context.setLocale(locale);
    state = AsyncData(locale);
  }
}

import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_ddd_template/application/core/language.dart';
import 'package:riverpod_ddd_template/application/core/network_info.dart';
import 'package:riverpod_ddd_template/common/constants/app_env.dart';
import 'package:riverpod_ddd_template/presentation/routes/app_router.dart';

import 'application/core/theme.dart';
import 'common/theme/themes.dart';
import 'common/widgets/app.dart';
import 'config.dart';

void main() {
  runZonedGuarded(
    () async {
      await setupConfigs();
      runApp(
        const ProviderScope(
          child: App(
            localesPath: "assets/tr",
            supportedLocales: [Locale('uz', 'UZ')],
            child: MyApp(),
          ),
        ),
      );
    },
    (error, stack) {
      if (kDebugMode) {
        print(error);
        print(stack);
      }
      // if you need crashlytics
      // FirebaseCrashlytics.instance.recordError(error, stack);
    },
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localeAsync = ref.watch(languageProvider);
    final themeAsync = ref.watch(themeProvider);
    ref.watch(networkInfoProvider);

    return MaterialApp.router(
      title: AppEnv.appName,
      debugShowCheckedModeBanner: AppEnv.debugMode,
      routerConfig: router.config(),
      builder: EasyLoading.init(),
      theme: AppTheme.theme(Brightness.light),
      darkTheme: AppTheme.theme(Brightness.dark),
      themeMode: themeAsync.valueOrNull ?? ThemeMode.system,
      locale: localeAsync.valueOrNull ?? context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
    );
  }
}

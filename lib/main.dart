import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_ddd_template/application/notifiers/locale_notifier.dart';
import 'package:riverpod_ddd_template/common/constants/app_env.dart';
import 'package:riverpod_ddd_template/presentation/routes/app_router.dart';

import 'common/widgets/app.dart';
import 'config.dart';

void main() {
  runZonedGuarded(
    () async {
      await setupConfigs();

      runApp(
        const App(
          localesPath: "assets/tr",
          supportedLocales: [Locale('uz', 'UZ')],
          child: MyApp(),
        ),
      );
    },
    (error, stack) {
      // if need crashlytics
      // FirebaseCrashlytics.instance.recordError(error, stack);
    },
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localeAsync = ref.watch(localeNotifierProvider);

    return MaterialApp.router(
      title: AppEnv.appName,
      debugShowCheckedModeBanner: AppEnv.debugMode,
      routerConfig: router.config(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      builder: EasyLoading.init(),
      locale: localeAsync.whenOrNull() ?? context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
    );
  }
}

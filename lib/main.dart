import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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
          supportedLocales: [Locale('uz-UZ')],
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppEnv.appName,
      debugShowCheckedModeBanner: AppEnv.debugMode,
      routerConfig: router.config(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      builder: EasyLoading.init(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:riverpod_ddd_template/common/constants/app_env.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppEnv.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppEnv.appName,
      debugShowCheckedModeBanner: AppEnv.debugMode,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const Scaffold(),
    );
  }
}
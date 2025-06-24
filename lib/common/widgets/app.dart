import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  final Widget child;
  final String localesPath;
  final List<Locale> supportedLocales;
  final bool enabledPreview;

  const App({
    super.key,
    required this.child,
    required this.localesPath,
    required this.supportedLocales,
    this.enabledPreview = false,
  });

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      supportedLocales: supportedLocales,
      path: localesPath,
      fallbackLocale: supportedLocales.first,
      startLocale: supportedLocales.first,
      useOnlyLangCode: supportedLocales.first.countryCode == null,
      saveLocale: true,
      child: child,
    );
  }
}

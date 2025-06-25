import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_ddd_template/common/widgets/app_images.dart';
import 'package:riverpod_ddd_template/common/words/words.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import 'splash_provider.dart';

@RoutePage()
class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  late final vm = ref.read(splashProvider.notifier);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => vm.init());
  }

  @override
  dispose() {
    print('dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(splashProvider);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.bottomCenter,
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: kToolbarHeight,
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.splash.path),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          spacing: 12,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Spacer(flex: 3),

            // App name
            Expanded(
              flex: 2,
              child: Center(
                child: TextAnimator(
                  key: UniqueKey(),
                  state.appName,
                  textAlign: TextAlign.center,
                  atRestEffect: WidgetRestingEffects.wave(),
                  style: const TextStyle(
                    fontSize: 56,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const CupertinoActivityIndicator(color: Colors.white),

            Text(
              "${Words.appVersion.str}: ${state.version}",
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_ddd_template/application/core/device_info.dart';
import 'package:riverpod_ddd_template/presentation/routes/app_router.dart';

part 'splash_provider.freezed.dart';

part 'splash_provider.g.dart';

@riverpod
class Splash extends _$Splash {
  @override
  SplashState build() => const SplashState.init();

  Future<void> init() async {
    final packageInfo = await ref.read(packageInfoProvider.future);
    state = state.copyWith(
      appName: packageInfo.appName,
      version: packageInfo.version,
    );

    await Future.delayed(const Duration(seconds: 2));
    router.replace(const DemoRoute());
  }
}

@freezed
abstract class SplashState with _$SplashState {
  const factory SplashState.init({
    @Default('') String appName,
    @Default('') String version,
  }) = _Init;
}

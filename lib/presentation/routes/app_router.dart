import 'package:auto_route/auto_route.dart';

import 'app_router.gr.dart';
export 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    // AutoRoute(
    //   initial: true,
    //   page: SplashRoute.page,
    //   type: const RouteType.cupertino(),
    // ),
  ];
}

final router = AppRouter();

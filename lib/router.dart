import 'package:auto_route/auto_route.dart';
import 'router.gr.dart' as gr;
import 'src/ui/guard/startup_loading_guard.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  

  @override
  RouteType get defaultRouteType => RouteType.material(); //.cupertino, .adaptive ..etc

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: gr.HomeRoute.page, path: "/", initial: true),
    AutoRoute(page: gr.AboutRoute.page, path: "/about"),
  ];

  @override
  List<AutoRouteGuard> get guards => [
    StartupLoadingGuard(),
  ];
}
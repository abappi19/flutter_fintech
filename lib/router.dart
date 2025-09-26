import 'package:auto_route/auto_route.dart';
import 'router.gr.dart' as gr;

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {

  @override
  RouteType get defaultRouteType => RouteType.material(); //.cupertino, .adaptive ..etc

  @override
  List<AutoRoute> get routes => [
    // HomeScreen is generated as HomeRoute because
    // of the replaceInRouteName property
    AutoRoute(page: gr.SplashRoute.page, initial: true),
    AutoRoute(page: gr.HomeRoute.page, path: "/"),
    AutoRoute(page: gr.AboutRoute.page, path: "/about"),
  ];

  @override
  List<AutoRouteGuard> get guards => [
    // optionally add root guards here
  ];
}
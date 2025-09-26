import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

bool _hasShown = false;

class StartupLoadingGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    if (_hasShown) {
      resolver.next(true);
      return;
    }
    print("StartupLoadingGuard");
    _hasShown = true;
    await Future<void>.delayed(const Duration(milliseconds: 4000));
    FlutterNativeSplash.remove();
    resolver.next(true);
  }
}

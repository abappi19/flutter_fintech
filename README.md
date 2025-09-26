# flutter_fintech

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Splash screen (flutter_native_splash)

This project uses `flutter_native_splash` to generate platform-native splash screens from a single YAML config.

### Where to edit

- Config file: `native_splash.yaml`
- Current settings (examples):
  - **Background color**: `color: "#42a5f5"`
  - **Splash image**: `image: assets/app_logo.png` (PNG recommended at 4x density)
  - **Platforms**: `android: true`, `ios: true`, `web: true`
  - **Android 12+**: configure in the `android_12:` section (uses masked circular icon)

### Common changes

- **Change background color**: update `color` (and optionally `color_dark` for dark mode)
- **Change image**: replace `assets/app_logo.png` and update the path in `image`
- **Dark mode variants**: set `color_dark`, `image_dark`, `branding_dark`
- **Android 12 specific**: set `android_12.image` and optionally `icon_background_color`

Notes:
- The splash image does not need to be listed under `flutter.assets` in `pubspec.yaml`.
- For Android 12:
  - With background layer: 960×960 inside a 640px diameter safe circle
  - Without background layer: 1152×1152 with important content inside a 768px diameter safe circle

### Generate / update the splash

Run after any change to `native_splash.yaml` or image files:

```bash
dart run flutter_native_splash:create
```

If you need to remove generated splash changes and restore defaults:

```bash
dart run flutter_native_splash:remove
```

Then rebuild your app (hot restart is not enough for native assets):

```bash
flutter run
```

### Troubleshooting

- **Android 12 shows a white screen**: ensure the `android_12:` section sets an `image` and/or `color`.
- **iOS status bar visibility**: if you enabled `fullscreen: true`, re-enable overlays in code using `SystemChrome.setEnabledSystemUIMode`.
- **Web layout**: adjust `web_image_mode` (e.g., `contain`, `cover`) in the config if needed.

### What gets generated (do not edit by hand)

- Android: `android/app/src/main/res/drawable*/launch_background.xml`, `values/styles.xml`, and Android 12 resources.
- iOS: updates to `ios/Runner/Base.lproj/LaunchScreen.storyboard` and `ios/Runner/Assets.xcassets` entries.
- Web: updates to `web/index.html` and splash assets.

Commit `native_splash.yaml` and the generated platform changes to keep builds consistent across environments.

## Add a new screen (AutoRoute)

Follow these steps to add a new screen and route using AutoRoute.

### 1) Create the screen widget

Create a file like `lib/src/ui/screen/profile_screen.dart` and annotate it with `@RoutePage()`:

```dart
// lib/src/ui/screen/profile_screen.dart
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Profile')),
    );
  }
}
```

### 2) Register the route

Update `lib/router.dart` and add a new `AutoRoute` entry using your generated route (note the `gr.` prefix):

```dart
// lib/router.dart
import 'package:auto_route/auto_route.dart';
import 'router.gr.dart' as gr;
import 'src/ui/guard/startup_loading_guard.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => RouteType.material();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: gr.HomeRoute.page, path: "/", initial: true),
    AutoRoute(page: gr.AboutRoute.page, path: "/about"),
    // New screen
    AutoRoute(page: gr.ProfileRoute.page, path: "/profile"),
  ];

  @override
  List<AutoRouteGuard> get guards => [
    StartupLoadingGuard(),
  ];
}
```

### 3) Generate the routes

Run code generation after creating the screen or modifying the router config:

```bash
dart run build_runner build --delete-conflicting-outputs
# Or keep the generator running:
dart run build_runner watch --delete-conflicting-outputs
```

This will update `lib/router.gr.dart` and create the `gr.ProfileRoute` you used above.

### 4) Navigate to the new screen

Use AutoRoute navigation helpers:

```dart
// Push by type-safe route
context.router.push(gr.ProfileRoute());

// Or navigate by path
context.router.replacePath('/profile');
```

### Tips

- If the `gr.YourRoute` symbol isn’t found, re-run the generator and confirm the screen has `@RoutePage()`.
- Keep `build_runner watch` running while you work to regenerate files automatically.
- If you change file/class names, re-run generation to sync `router.gr.dart`.

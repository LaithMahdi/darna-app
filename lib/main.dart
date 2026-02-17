import 'package:flutter/material.dart';
import 'core/config.dart';
import 'core/constants/app_theme.dart';
import 'routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: Config.appName,
      routerConfig: Routes.router,
      debugShowCheckedModeBanner: Config.isDebugMode,
      theme: AppTheme.lightTheme,
    );
  }
}

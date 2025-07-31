import 'package:flutter/material.dart';
import 'routes/app_routes.dart';
import 'routes/navigation_helper.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const HashKartApp());
}

class HashKartApp extends StatelessWidget {
  const HashKartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HashKart',
      navigatorKey: NavigationHelper.navigatorKey,
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.splash,
      onGenerateRoute: AppRoutes.generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}

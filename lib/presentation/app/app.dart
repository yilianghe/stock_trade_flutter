import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../shared/design_system/app_theme.dart';
import '../routes/app_router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      theme: AppTheme.light(),
      routes: AppRouter.routes,
      initialRoute: AppRouter.home,
    );
  }
}

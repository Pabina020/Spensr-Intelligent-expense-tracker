import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spensr/theme/app_theme_manager.dart';
import 'package:spensr/screen/authentication/view/login_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppThemeManager(),
      child: const SpensrApp(),
    ),
  );
}

class SpensrApp extends StatelessWidget {
  const SpensrApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<AppThemeManager>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeManager.theme,      // uses your AppTheme.dark/light
      home: const LoginView(),        // launches your login page
    );
  }
}

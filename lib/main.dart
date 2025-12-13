import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spensr/screen/authentication/view/login_page.dart';
import 'package:spensr/screen/category/view/add_new_categories.dart';
import 'package:spensr/screen/home/view/homeview.dart';  // Import your HomeView here
import 'package:spensr/screen/text_transaction/view/add_transaction_view.dart';
import 'package:spensr/theme/app_theme_manager.dart'; // Import the AppThemeManager class

void main() {
  runApp(
    // Wrap your app with ChangeNotifierProvider to provide theme state to the app
    ChangeNotifierProvider(
      create: (_) => AppThemeManager(),  // AppThemeManager manages the theme state
      child: const SpensrApp(),
    ),
  );
}

class SpensrApp extends StatelessWidget {
  const SpensrApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieve the theme from the AppThemeManager
    final themeManager = Provider.of<AppThemeManager>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeManager.theme,  // Sets the theme of the app (either light or dark)
      home: LoginView(),           // Home screen that launches after app starts
    );
  }
}

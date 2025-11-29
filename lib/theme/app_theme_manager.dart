import 'package:flutter/material.dart';
import 'package:spensr/theme/app_theme.dart';
import 'package:spensr/theme/app_colors.dart';

class AppThemeManager extends ChangeNotifier {
  bool _isDark = true;

  AppThemeManager();

  bool get isDark => _isDark;

  ThemeData get theme =>
      _isDark ? AppTheme.dark(AppColors.data()) : AppTheme.light(AppColors.data());

  AppColors get colors => AppColors.data();

  void toggleTheme() {
    _isDark = !_isDark;
    notifyListeners();
  }
}

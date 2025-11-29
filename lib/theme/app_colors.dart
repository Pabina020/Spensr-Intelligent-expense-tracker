import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spensr/theme/app_colors.dart' as prefix0;
import 'package:spensr/theme/app_theme_manager.dart';


class AppColors {
  final Color backgroundColor;

  final Color primaryText;
  final Color orangeText;

  final Color primary;
  final Color solidBlack;
  final Color imageBackground;
  final Color onboardingBackground;
  final Color containerBG;
  final Color tileBG;
  final Color disabledText;
  final Color barchartBG;
  final Color transactionPage;

  final Color containerBG2;
  final Color secondaryBG;

  final Color premiumGreen;
  final Color premiumYellow;
  final Color premiumPurple;

  final Color primaryGrey;
  final Color secondaryGrey;

  final Color brownishYellow;
  final Color yellow;

  final Color disabled;

  /// ------------------------------
  /// CLEAN CORRECT CONSTRUCTOR
  /// ------------------------------
  AppColors({
    required this.backgroundColor,
    required this.primaryText,
    required this.primary,
    required this.solidBlack,
    required this.imageBackground,
    required this.onboardingBackground,
    required this.containerBG,
    required this.tileBG,
    required this.disabledText,
    required this.barchartBG,
    required this.transactionPage,
    required this.containerBG2,
    required this.orangeText,
    required this.premiumGreen,
    required this.premiumYellow,
    required this.premiumPurple,
    required this.primaryGrey,
    required this.secondaryBG,
    required this.secondaryGrey,
    required this.brownishYellow,
    required this.yellow,
    required this.disabled,
  });

  /// ------------------------------
  /// STATIC DARK THEME COLORS
  /// ------------------------------
  static AppColors data() {
    return AppColors(
      backgroundColor: _AppColors.backgroundColor,
      primaryText: _AppColors.primaryText,
      primary: _AppColors.primary,
      solidBlack: _AppColors.solidBlack,
      imageBackground: _AppColors.imageBackground,
      onboardingBackground: _AppColors.onboardingBackground,
      containerBG: _AppColors.containerBG,
      tileBG: _AppColors.tileBG,
      disabledText: _AppColors.disabledText,
      barchartBG: _AppColors.barchartBG,
      transactionPage: _AppColors.transactionPage,
      containerBG2: _AppColors.containerBG2,
      orangeText: _AppColors.orangeText,
      premiumGreen: _AppColors.premiumGreen,
      premiumYellow: _AppColors.premiumYellow,
      premiumPurple: _AppColors.premiumPurple,
      primaryGrey: _AppColors.primaryGrey,
      secondaryBG: _AppColors.secondaryBG,
      secondaryGrey: _AppColors.secondaryGrey,
      brownishYellow: _AppColors.brownishYellow,
      yellow: _AppColors.yellow,
      disabled: _AppColors.disabled,
    );
  }

  /// ------------------------------
  /// ACCESS FROM ANY WIDGET
  /// ------------------------------
  static prefix0.AppColors of(BuildContext context) =>
      Provider.of<AppThemeManager>(context, listen: false).colors;
}

class _AppColors {
  static const Color backgroundColor = Color(0xFF0D0F12);
  static const Color primaryText = Color(0xFFFFFFFF);
  static const Color primary = Color(0xFF6366F1);
  static const Color solidBlack = Color(0xFF000000);

  static const Color imageBackground = Color(0xFF1A1D23);
  static const Color onboardingBackground = Color(0xFF11151C);

  static const Color containerBG = Color(0xFF1A1D23);
  static const Color tileBG = Color(0xFF1E222A);

  static const Color disabledText = Color(0xFFB3B6C2);
  static const Color barchartBG = Color(0xFF252B36);
  static const Color transactionPage = Color(0xFF161A20);
  static const Color containerBG2 = Color(0xFF2A2F3C);

  static const Color orangeText = Color(0xFFF97316);
  static const Color premiumGreen = Color(0xFF10B981);
  static const Color premiumYellow = Color(0xFFFACC15);
  static const Color premiumPurple = Color(0xFF8B5CF6);

  static const Color primaryGrey = Color(0xFF9CA3AF);
  static const Color secondaryBG = Color(0xFF12151B);
  static const Color secondaryGrey = Color(0xFFD1D5DB);

  static const Color brownishYellow = Color(0xFFB38A3E);
  static const Color yellow = Color(0xFFFFD85F);

  static const Color disabled = Color(0xFF3A3F47);
}

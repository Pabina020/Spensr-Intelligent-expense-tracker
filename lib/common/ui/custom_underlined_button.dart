import 'package:flutter/material.dart';
import 'package:spensr/theme/app_colors.dart';

class CustomUnderlinedButton extends StatelessWidget {
  final String? buttonLabel;
  final VoidCallback? onPressed;
  const CustomUnderlinedButton({
    super.key,
    required this.buttonLabel,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Text(
        buttonLabel!,
        style: TextStyle(
          color: AppColors.of(context).primary,
          fontSize: 15,
          fontWeight: FontWeight.w600,
          decoration: TextDecoration.underline,
          decorationColor: AppColors.of(context).primary,
        ),
      ),
    );
  }
}

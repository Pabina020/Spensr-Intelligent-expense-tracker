
import 'package:flutter/material.dart';
import 'package:spensr/theme/app_colors.dart';

class CustomOutlinedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String buttonLabel;
  final bool disabled;
  final Color? disabledColor;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  final Color? borderColor;

  const CustomOutlinedButton({
    Key? key,
    required this.onPressed,
    required this.buttonLabel,
    this.disabled = false,
    this.disabledColor,
    this.borderRadius = 30,
    this.padding,
    this.textStyle,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final bool isEnabled = onPressed != null && !disabled;

    return OutlinedButton(
      onPressed: isEnabled ? onPressed : null,
      style: OutlinedButton.styleFrom(
        padding: padding ?? const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 14,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        side: BorderSide(
          color: isEnabled 
              ? (borderColor ?? colors.primaryText.withOpacity(0.5))
              : (disabledColor ?? colors.disabled),
          width: 1.5,
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: isEnabled 
            ? colors.primaryText 
            : (disabledColor ?? colors.disabled),
      ),
      child: Text(
        buttonLabel,
        style: textStyle ?? TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: isEnabled 
              ? colors.primaryText 
              : (disabledColor ?? colors.disabled),
        ),
      ),
    );
  }
}

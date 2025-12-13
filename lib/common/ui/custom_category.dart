import 'package:flutter/material.dart';
import 'package:spensr/common/ui/custom_keyboard_hide.dart';
import 'package:spensr/theme/app_colors.dart';

class CustomCategory extends StatelessWidget {
  final String emoji;
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const CustomCategory({
    super.key,
    required this.emoji,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CustomKeyboardHide(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.of(context).containerBG,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color:
                  isSelected
                      ? AppColors.of(context).primary
                      : Colors.transparent,
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(emoji, style: const TextStyle(fontSize: 24)),
                const SizedBox(width: 12),
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 15,
                    color: AppColors.of(context).primaryText,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:spensr/common/ui/custom_loader.dart';
import 'package:spensr/theme/app_colors.dart';

class CustomGradientButton extends StatelessWidget {
  final Function()? onPressed;
  final double borderRadius;
  final Color? color;
  final bool busy;
  final String? buttonLabel;
  final Color disabledColor;

  const CustomGradientButton({
    super.key,
    this.onPressed,
    this.borderRadius = 12.0,
    this.color,
    this.busy = false,
    required this.buttonLabel,
    this.disabledColor = const Color(0xFF212121),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: onPressed == null ? disabledColor : null,
          gradient:
              onPressed != null
                  ? const LinearGradient(
                    colors: [
                      Color(0xFF20B9F0),
                      Color(0xFF0094FF),
                      Color(0xFF97A1FC),
                    ],
                    stops: [0.0, 0.51, 1.0],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  )
                  : null,
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child:
            busy
                ? CustomLoader.minimal()
                : Text(
                  buttonLabel ?? "",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color:
                        onPressed == null
                            ? Colors.white30
                            : (AppColors.of(context).primaryText),
                  ),
                ),
      ),
    );
  }
}

class CustomOutlinedButton extends StatelessWidget {
  final Function()? onPressed;
  final double borderRadius;
  final Color? color;
  final bool busy;
  final String? buttonLabel;
  final Color disabledColor;

  const CustomOutlinedButton({
    super.key,
    this.onPressed,
    this.borderRadius = 12.0,
    this.color,
    this.busy = false,
    required this.buttonLabel,
    this.disabledColor = const Color(0xFF212121),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: onPressed == null ? disabledColor : null,

          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          border: Border.all(
            color: onPressed == null ? disabledColor : Color(0xFF97A1FC),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 11),
        child:
            busy
                ? Center(child: CustomLoader.minimal())
                : Center(
                  child: Text(
                    buttonLabel ?? "",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color:
                          onPressed == null
                              ? Colors.white30
                              : (AppColors.of(context).primaryText),
                    ),
                  ),
                ),
      ),
    );
  }
}

class CustomGradientIconButton extends StatelessWidget {
  final Function()? onPressed;
  final double borderRadius;
  final Color? color;
  final bool busy;
  final Widget icon;
  final Color disabledColor;
  final String? tooltip;

  const CustomGradientIconButton({
    super.key,
    this.onPressed,
    this.borderRadius = 12.0,
    this.color,
    this.busy = false,
    required this.icon,
    this.disabledColor = const Color(0xFF212121),
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip ?? '',
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            color: onPressed == null ? disabledColor : null,
            gradient:
                onPressed != null
                    ? const LinearGradient(
                      colors: [
                        Color(0xFF20B9F0),
                        Color(0xFF0094FF),
                        Color(0xFF97A1FC),
                      ],
                      stops: [0.0, 0.51, 1.0],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    )
                    : null,
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: busy ? Center(child: CustomLoader.minimal()) : icon,
        ),
      ),
    );
  }
}

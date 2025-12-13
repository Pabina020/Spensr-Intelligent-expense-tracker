import 'package:flutter/material.dart';
import 'package:spensr/theme/app_colors.dart';

class CustomScaffold extends StatelessWidget {
  final String? title;
  final bool? showBackButton;
  final Widget body;
  final bool floating;
  final VoidCallback? onFabPressed;
  final Widget? leading;

  const CustomScaffold({
    super.key,
    this.title,
    this.showBackButton = false,
    required this.body,
    this.floating = false,
    this.onFabPressed,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: leading,
        actionsIconTheme: IconThemeData(
          color: AppColors.of(context).primaryText,
        ),
        iconTheme: IconThemeData(color: AppColors.of(context).primaryText),
        title: Text(
          title ?? "",
          style: TextStyle(
            color: AppColors.of(context).primaryText,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: showBackButton ?? false,
      ),
      body: body,
      floatingActionButton:
          floating == true
              ? GestureDetector(
                onTap: onFabPressed,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF2FD3E8),
                        Color(0xFF5DADF6),
                        Color(0xFF98A1FD),
                      ],
                      stops: [0.0, 0.50, 1.0],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    shape: BoxShape.circle,
                  ),

                  child: Icon(Icons.add, color: Colors.white),
                ),
              )
              : null,
    );
  }
}

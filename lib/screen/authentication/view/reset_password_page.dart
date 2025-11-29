import 'package:flutter/material.dart';
import 'package:spensr/theme/app_colors.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  bool showPass = false;
  bool showConfirm = false;

  final passController = TextEditingController();
  final confirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Scaffold(
      backgroundColor: colors.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            _header(colors, "Create new password"),
            Expanded(
              child: SingleChildScrollView(
                child: _card(
                  colors,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(child: _circleIcon(colors, Icons.security)),
                      const SizedBox(height: 14),

                      Center(
                        child: Text(
                          "Reset Your password",
                          style: TextStyle(
                            color: colors.primaryText,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),
                      Center(
                        child: Text(
                          "Your new password must be different than\nprevious password",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: colors.primaryGrey),
                        ),
                      ),

                      const SizedBox(height: 22),
                      Text("New Password", style: TextStyle(color: colors.primaryText)),
                      const SizedBox(height: 6),
                      _passwordField(colors, passController, showPass, () {
                        setState(() => showPass = !showPass);
                      }),

                      const SizedBox(height: 16),
                      Text("Confirm Password",
                          style: TextStyle(color: colors.primaryText)),
                      const SizedBox(height: 6),
                      _passwordField(colors, confirmController, showConfirm, () {
                        setState(() => showConfirm = !showConfirm);
                      }),

                      const SizedBox(height: 26),
                      _primaryButton(colors, "Confirm", () {
  Navigator.popUntil(context, (route) => route.isFirst);
})

                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ------------------------- COMPONENTS -------------------------

  Widget _header(AppColors colors, String title) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30),
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [colors.primary, colors.premiumPurple],
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.arrow_back, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 6),
          const Text(
            "Spensr",
            style: TextStyle(
                color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(title, style: const TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }

  Widget _card(AppColors colors, {required Widget child}) {
    return Transform.translate(
      offset: const Offset(0, -20),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: colors.containerBG,
          borderRadius: BorderRadius.circular(22),
        ),
        child: child,
      ),
    );
  }

  Widget _circleIcon(AppColors colors, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colors.tileBG,
      ),
      child: Icon(icon, color: colors.primary, size: 32),
    );
  }

  Widget _passwordField(AppColors colors, TextEditingController controller,
      bool visible, VoidCallback toggle) {
    return TextField(
      controller: controller,
      obscureText: !visible,
      style: TextStyle(color: colors.primaryText),
      decoration: InputDecoration(
        filled: true,
        fillColor: colors.tileBG,
        hintText: "Enter password",
        hintStyle: TextStyle(color: colors.secondaryGrey),
        suffixIcon: GestureDetector(
          onTap: toggle,
          child: Icon(
            visible ? Icons.visibility : Icons.visibility_off,
            color: colors.primaryGrey,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colors.containerBG2),
        ),
      ),
    );
  }

  Widget _primaryButton(AppColors colors, String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [colors.primary, colors.premiumPurple],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }
}

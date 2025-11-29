import 'package:flutter/material.dart';
import 'package:spensr/theme/app_colors.dart';
import 'package:spensr/screen/authentication/view/verification_code_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Scaffold(
      backgroundColor: colors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _header(colors, "Forgot Password"),
              _card(
                colors,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(child: _circleIcon(colors, Icons.lock_outline)),
                    const SizedBox(height: 14),

                    Center(
                      child: Text(
                        "Forgot your password?",
                        style: TextStyle(
                          color: colors.primaryText,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 6),
                    Center(
                      child: Text(
                        "Please enter your registered email.\nYou will receive a verification code.",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: colors.primaryGrey, height: 1.4),
                      ),
                    ),

                    const SizedBox(height: 22),

                    Text("Email", style: TextStyle(color: colors.primaryText)),
                    const SizedBox(height: 6),

                    _inputField(colors, emailController, "Your email"),

                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        "Try another way",
                        style: TextStyle(
                            color: colors.primary,
                            decoration: TextDecoration.underline),
                      ),
                    ),

                    const SizedBox(height: 20),

                   _primaryButton(colors, "Send Code", () {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => const VerificationCodePage()),
  );
})

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ------------------------ UI COMPONENTS ------------------------

  Widget _header(AppColors colors, String title) {
    return Container(
      padding: const EdgeInsets.only(top: 28, bottom: 34),
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [colors.primary, colors.premiumPurple],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
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
          const SizedBox(height: 2),
          Text(title, style: const TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }

  Widget _card(AppColors colors, {required Widget child}) {
    return Transform.translate(
      offset: const Offset(0, -20),
      child: Container(
        width: double.infinity,
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

  Widget _inputField(
    AppColors colors,
    TextEditingController controller,
    String hint,
  ) {
    return TextField(
      controller: controller,
      style: TextStyle(color: colors.primaryText),
      decoration: InputDecoration(
        filled: true,
        fillColor: colors.tileBG,
        hintText: hint,
        hintStyle: TextStyle(color: colors.secondaryGrey),
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
          child: Text(text,
              style: const TextStyle(color: Colors.white, fontSize: 16)),
        ),
      ),
    );
  }
}

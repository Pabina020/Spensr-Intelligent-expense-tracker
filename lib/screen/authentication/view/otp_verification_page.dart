import 'package:flutter/material.dart';
import 'package:spensr/theme/app_colors.dart';

class OtpVerificationPage extends StatefulWidget {
  const OtpVerificationPage({super.key});

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final List<TextEditingController> controllers =
      List.generate(6, (index) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Scaffold(
      backgroundColor: colors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _header(colors, "Verify Email"),
              _card(
                colors,
                child: Column(
                  children: [
                    _circleIcon(colors, Icons.verified),
                    const SizedBox(height: 12),
                    Text(
                      "OTP Verification",
                      style: TextStyle(
                        color: colors.primaryText,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Please type the OTP verification code sent to\np********@gmail.com",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: colors.primaryGrey, fontSize: 13),
                    ),
                    const SizedBox(height: 22),

                    /// OTP BOXES
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        6,
                        (index) => _otpBox(colors, controllers[index]),
                      ),
                    ),

                    const SizedBox(height: 12),

                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Resend code",
                        style: TextStyle(color: colors.primary),
                      ),
                    ),

                    const SizedBox(height: 18),

                    /// VERIFY BUTTON
                    _primaryButton(colors, "Verify", () {}),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --------------------------- UI HELPERS ---------------------------
  Widget _header(AppColors colors, String title) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30),
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
          const SizedBox(height: 8),
          const Text(
            "Spensr",
            style: TextStyle(
                color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
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

  Widget _otpBox(AppColors colors, TextEditingController controller) {
    return SizedBox(
      width: 40,
      height: 48,
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        maxLength: 1,
        textAlign: TextAlign.center,
        style: TextStyle(color: colors.primaryText, fontSize: 18),
        decoration: InputDecoration(
          counterText: "",
          filled: true,
          fillColor: colors.tileBG,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: colors.containerBG2),
          ),
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

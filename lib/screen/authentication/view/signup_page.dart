import 'package:flutter/material.dart';
import 'package:spensr/theme/app_colors.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  bool agree = false;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final confirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Scaffold(
      backgroundColor: colors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// TOP BLUE HEADER
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 36),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      colors.primary,
                      colors.premiumPurple,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Column(
                  children: [
                    Text(
                      "Spensr",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "Get Started!",
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// CARD CONTAINER
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                  color: colors.containerBG,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Title
                    Center(
                      child: Text(
                        "Signup",
                        style: TextStyle(
                          color: colors.primaryText,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    /// Full Name
                    _textLabel("Full Name *", colors),
                    _inputField(
                      controller: nameController,
                      hint: "Enter your full name",
                      colors: colors,
                    ),
                    const SizedBox(height: 16),

                    /// Email
                    _textLabel("Email *", colors),
                    _inputField(
                      controller: emailController,
                      hint: "you123@gmail.com",
                      colors: colors,
                    ),
                    const SizedBox(height: 16),

                    /// Password
                    _textLabel("Password *", colors),
                    _passwordField(
                      controller: passController,
                      visible: isPasswordVisible,
                      onToggle: () => setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      }),
                      colors: colors,
                    ),
                    const SizedBox(height: 16),

                    /// Confirm Password
                    _textLabel("Confirm Password *", colors),
                    _passwordField(
                      controller: confirmController,
                      visible: isConfirmPasswordVisible,
                      onToggle: () => setState(() {
                        isConfirmPasswordVisible =
                            !isConfirmPasswordVisible;
                      }),
                      colors: colors,
                    ),
                    const SizedBox(height: 16),

                    /// Agreement Checkbox
                    Row(
                      children: [
                        Checkbox(
                          value: agree,
                          activeColor: colors.primary,
                          side:
                              // ignore: deprecated_member_use
                              BorderSide(color: colors.primaryText.withOpacity(0.4)),
                          onChanged: (v) => setState(() => agree = v ?? false),
                        ),
                        Expanded(
                          child: Text(
                            "I agree to the terms & policy of Spensr",
                            style: TextStyle(
                              color: colors.primaryGrey,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    /// SIGNUP BUTTON
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              colors.primary,
                              colors.premiumPurple,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            "Signup",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 22),

                    /// Divider
                    Row(
                      children: [
                        Expanded(
                          child: Divider(color: Colors.grey.shade800),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text("OR Signup with",
                              style: TextStyle(color: Colors.grey)),
                        ),
                        Expanded(
                          child: Divider(color: Colors.grey.shade800),
                        ),
                      ],
                    ),

                    const SizedBox(height: 22),

                    /// Google & Apple Login
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _socialIcon(colors, Icons.g_mobiledata),
                        const SizedBox(width: 30),
                        _socialIcon(colors, Icons.apple),
                      ],
                    ),

                    const SizedBox(height: 20),

                    /// Already have account
                   Center(
  child: GestureDetector(
    onTap: () {
      Navigator.pop(context);
    },
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already have an account? ",
          style: TextStyle(color: colors.primaryGrey),
        ),
        Text(
          "Login",
          style: TextStyle(
            color: colors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  ),
),

                  ],
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  /// -------------------------
  /// REUSABLE WIDGETS BELOW
  /// -------------------------

  Widget _textLabel(String text, AppColors colors) {
    return Text(
      text,
      style: TextStyle(color: colors.primaryText, fontSize: 14),
    );
  }

  Widget _inputField({
    required TextEditingController controller,
    required String hint,
    required AppColors colors,
  }) {
    return TextField(
      controller: controller,
      style: TextStyle(color: colors.primaryText),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: colors.secondaryGrey),
        filled: true,
        fillColor: colors.tileBG,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colors.containerBG2),
        ),
      ),
    );
  }

  Widget _passwordField({
    required TextEditingController controller,
    required bool visible,
    required Function onToggle,
    required AppColors colors,
  }) {
    return TextField(
      controller: controller,
      obscureText: !visible,
      style: TextStyle(color: colors.primaryText),
      decoration: InputDecoration(
        hintText: "Enter your password",
        hintStyle: TextStyle(color: colors.secondaryGrey),
        filled: true,
        fillColor: colors.tileBG,
        suffixIcon: IconButton(
          icon: Icon(
            visible ? Icons.visibility : Icons.visibility_off,
            color: colors.primaryGrey,
          ),
          onPressed: () => onToggle(),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colors.containerBG2),
        ),
      ),
    );
  }

  Widget _socialIcon(AppColors colors, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colors.tileBG,
      ),
      child: Icon(icon, color: colors.primaryText, size: 32),
    );
  }
}

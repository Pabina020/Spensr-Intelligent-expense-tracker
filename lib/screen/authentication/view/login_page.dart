import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spensr/screen/authentication/view/forget_password_page.dart';
import 'package:spensr/theme/app_colors.dart';
import 'package:spensr/screen/home/view/homeview.dart';  // Import HomeView

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isLogin = true;
  bool isRememberMe = false;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
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
              // -------------------------
              // HEADER (Blue gradient)
              // -------------------------
              Container(
                height: 170,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [colors.primary, colors.premiumPurple],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Spensr",
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Get Started!",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    )
                  ],
                ),
              ),

              // -------------------------
              // MAIN CARD CONTAINER
              // -------------------------
              Container(
                width: double.infinity,
                transform: Matrix4.translationValues(0, -25, 0),
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        isLogin ? "Login" : "Signup",
                        style: TextStyle(
                          color: colors.primaryText,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Full Name (signup only)
                    if (!isLogin) ...[
                      inputField("Full Name", nameController, colors),
                      const SizedBox(height: 16),
                    ],

                    // Email
                    inputField("Email Address", emailController, colors),
                    const SizedBox(height: 16),

                    // Password
                    inputField("Password", passwordController, colors, obscure: true),
                    const SizedBox(height: 16),

                    // Confirm Password
                    if (!isLogin) ...[
                      inputField("Confirm Password", confirmController, colors, obscure: true),
                      const SizedBox(height: 16),
                    ],

                    if (isLogin)
                      // Remember me + Forgot Password (same line)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // LEFT SIDE — Remember Me
                          Row(
                            children: [
                              Checkbox(
                                value: isRememberMe,
                                activeColor: colors.primary,
                                onChanged: (v) => setState(() => isRememberMe = v ?? false),
                              ),
                              const Text(
                                "Remember Me",
                                style: TextStyle(color: Colors.white70, fontSize: 13),
                              ),
                            ],
                          ),

                          // RIGHT SIDE — Forgot Password
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => const ForgotPasswordPage()),
                              );
                            },
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(
                                color: colors.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),

                    const SizedBox(height: 14),

                    // SIGNUP / LOGIN BUTTON
                    GestureDetector(
                      onTap: () async {
                        // Perform login logic here, e.g., Firebase authentication
                        bool loginSuccessful = await _loginWithFirebase();
                        if (loginSuccessful) {
                          // Navigate to HomeView after successful login
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => HomeView()),
                          );
                        } else {
                          // Handle login failure, e.g., show an error message
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Login failed!")),
                          );
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: colors.primary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            isLogin ? "Login" : "Signup",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 26),

                    // Divider
                    const Row(
                      children: [
                        Expanded(child: Divider(color: Colors.white24)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text("Or Signup with", style: TextStyle(color: Colors.white54)),
                        ),
                        Expanded(child: Divider(color: Colors.white24)),
                      ],
                    ),

                    const SizedBox(height: 22),

                    // Google + Apple
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        circleIconButton(Icons.g_mobiledata, colors),
                        const SizedBox(width: 24),
                        circleIconButton(Icons.apple, colors),
                      ],
                    ),

                    const SizedBox(height: 26),

                    // Toggle login <-> signup
                    Center(
                      child: GestureDetector(
                        onTap: () => setState(() => isLogin = !isLogin),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              isLogin
                                  ? "Don’t have an account?"
                                  : "Already have an account?",
                              style: const TextStyle(color: Colors.white70, fontSize: 14),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              isLogin ? "Signup" : "Login",
                              style: TextStyle(
                                color: colors.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // ------------------------------------------------
  // CUSTOM INPUT FIELD
  // ------------------------------------------------
  Widget inputField(
      String label, TextEditingController controller, AppColors colors,
      {bool obscure = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white70)),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          obscureText: obscure,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.black54,
            hintText: "Enter $label",
            hintStyle: const TextStyle(color: Colors.white38),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: colors.secondaryGrey),
            ),
          ),
        ),
      ],
    );
  }

  // ------------------------------------------------
  // SOCIAL BUTTON
  // ------------------------------------------------
  Widget circleIconButton(IconData icon, AppColors colors) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colors.tileBG,
      ),
      child: Icon(icon, color: Colors.white, size: 30),
    );
  }

  // Simulate login using Firebase (you can replace this with actual login logic)
  Future<bool> _loginWithFirebase() async {
    // Replace this with your Firebase authentication logic
    await Future.delayed(Duration(seconds: 2));
    return true;  // Simulate successful login
  }
}

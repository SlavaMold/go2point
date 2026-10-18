import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/app_button.dart';
import '../widgets/app_logo.dart';
import '../widgets/app_text_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: scheme.surface,

      appBar: AppBar(backgroundColor: scheme.surface, elevation: 0),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),

              // Логотип
              const AppLogo(),

              const SizedBox(height: 50),

              // Заголовок
              Text(
                'Welcome back!',
                style: GoogleFonts.quicksand(
                  fontSize: 34,
                  fontWeight: FontWeight.w800,
                  color: scheme.onSurface,
                ),
              ),

              const SizedBox(height: 8),

              // Подзаголовок
              Text(
                'Plan your next journey',
                style: GoogleFonts.quicksand(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: scheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 40),

              // Email input
              const AppTextField(
                label: 'Email',
                hint: 'your@email.com',
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 22),

              // Password input
              const AppTextField(
                label: 'Password',
                hint: 'Enter your password',
                obscureText: true,
              ),

              const SizedBox(height: 32),

              // Sign In button
              AppButton(text: 'Sign In', onPressed: () {}),

              const SizedBox(height: 22),

              // Sign Up link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: GoogleFonts.quicksand(
                      fontSize: 14,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      'Sign Up',
                      style: GoogleFonts.quicksand(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: scheme.primary,
                        decoration: TextDecoration.underline,
                        decorationColor: scheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

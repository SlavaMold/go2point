import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_colors.dart';
import '../widgets/app_button.dart';
import '../widgets/app_logo.dart';
import '../widgets/app_text_field.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,

      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 28,
            vertical: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppLogo(),

              const SizedBox(height: 45),

              Text(
                'Create account',
                style: GoogleFonts.quicksand(
                  fontSize: 34,
                  fontWeight: FontWeight.w800,
                  color: AppColors.darkText,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Start planning your next journey',
                style: GoogleFonts.quicksand(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.secondaryText,
                ),
              ),

              const SizedBox(height: 36),

              const AppTextField(
                label: 'Name',
                hint: 'Your name',
              ),

              const SizedBox(height: 22),

              const AppTextField(
                label: 'Email',
                hint: 'your@email.com',
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 22),

              const AppTextField(
                label: 'Password',
                hint: 'Create a password',
                obscureText: true,
              ),

              const SizedBox(height: 22),

              const AppTextField(
                label: 'Confirm password',
                hint: 'Repeat your password',
                obscureText: true,
              ),

              const SizedBox(height: 32),

              AppButton(
                text: 'Sign Up',
                onPressed: () {},
              ),

              const SizedBox(height: 22),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account? ',
                    style: GoogleFonts.quicksand(
                      fontSize: 14,
                      color: AppColors.secondaryText,
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
                      'Sign In',
                      style: GoogleFonts.quicksand(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.purple,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.purple,
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
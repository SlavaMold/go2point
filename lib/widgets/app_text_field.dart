import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_colors.dart';

class AppTextField extends StatelessWidget {
  final String label;
  final String hint;

  final IconData? prefixIcon;
  final IconData? suffixIcon;

  final String? prefixText;

  final bool obscureText;
  final bool readOnly;
  final bool enabled;

  final TextInputType? keyboardType;

  final TextEditingController? controller;

  final VoidCallback? onTap;

  final List<TextInputFormatter>? inputFormatters;

  const AppTextField({
    super.key,
    required this.label,
    required this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.prefixText,
    this.obscureText = false,
    this.readOnly = false,
    this.enabled = true,
    this.keyboardType,
    this.controller,
    this.onTap,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.quicksand(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: AppColors.darkText,
          ),
        ),

        const SizedBox(height: 8),

        TextField(
          controller: controller,
          obscureText: obscureText,
          readOnly: readOnly,
          enabled: enabled,
          keyboardType: keyboardType,
          onTap: onTap,
          inputFormatters: inputFormatters,

          decoration: InputDecoration(
            hintText: hint,
            prefixText: prefixText,

            prefixStyle: GoogleFonts.quicksand(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.darkText,
            ),

            prefixIcon: prefixIcon != null
                ? Icon(
                    prefixIcon,
                    color: AppColors.secondaryText,
                  )
                : null,

            suffixIcon: suffixIcon != null
                ? Icon(
                    suffixIcon,
                    color: AppColors.purple,
                  )
                : null,

            hintStyle: GoogleFonts.quicksand(
              color: AppColors.hintText,
            ),

            filled: true,
            fillColor: AppColors.fieldBackground,

            contentPadding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 17,
            ),

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
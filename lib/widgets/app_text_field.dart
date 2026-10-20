import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

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
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;
  final TextInputAction textInputAction;
  final TextCapitalization textCapitalization;
  final ValueChanged<String>? onFieldSubmitted;

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
    this.validator,
    this.onSaved,
    this.textInputAction = TextInputAction.next,
    this.textCapitalization = TextCapitalization.none,
    this.onFieldSubmitted,
    this.onTap,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.quicksand(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: scheme.onSurface,
          ),
        ),

        const SizedBox(height: 8),

        TextFormField(
          controller: controller,
          validator: validator,
          onSaved: onSaved,
          textInputAction: textInputAction,
          textCapitalization: textCapitalization,
          onFieldSubmitted: onFieldSubmitted,
          obscureText: obscureText,
          readOnly: readOnly,
          enabled: enabled,
          keyboardType: keyboardType,
          onTap: onTap,
          inputFormatters: inputFormatters,

          decoration: InputDecoration(
            hintText: hint,
            errorMaxLines: 3,
            prefixText: prefixText,

            prefixStyle: GoogleFonts.quicksand(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: scheme.onSurface,
            ),

            prefixIcon: prefixIcon != null
                ? Icon(prefixIcon, color: scheme.onSurfaceVariant)
                : null,

            suffixIcon: suffixIcon != null
                ? Icon(suffixIcon, color: scheme.primary)
                : null,

            hintStyle: GoogleFonts.quicksand(color: scheme.outlineVariant),

            filled: true,
            fillColor: scheme.surfaceContainerHighest,

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

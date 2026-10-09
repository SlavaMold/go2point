import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_colors.dart';

class SectionTitle extends StatelessWidget {
  final String number;
  final String title;

  const SectionTitle({
    super.key,
    required this.number,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          alignment: Alignment.center,

          decoration: const BoxDecoration(
            color: AppColors.lightPurple,
            shape: BoxShape.circle,
          ),

          child: Text(
            number,
            style: GoogleFonts.quicksand(
              fontWeight: FontWeight.w800,
              color: AppColors.purple,
            ),
          ),
        ),

        const SizedBox(width: 10),

        Text(
          title,
          style: GoogleFonts.quicksand(
            fontSize: 19,
            fontWeight: FontWeight.w800,
            color: AppColors.darkText,
          ),
        ),
      ],
    );
  }
}
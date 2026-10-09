import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_colors.dart';

class AppLogo extends StatelessWidget {
  final double fontSize;
  final double iconSize;

  const AppLogo({
    super.key,
    this.fontSize = 24,
    this.iconSize = 32,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Go2Point',
          style: GoogleFonts.quicksand(
            fontSize: fontSize,
            fontWeight: FontWeight.w700,
            color: AppColors.darkText,
          ),
        ),

        const SizedBox(width: 8),

        SvgPicture.asset(
          'assets/icons/go2point_icon.svg',
          height: iconSize,
          width: iconSize,
        ),
      ],
    );
  }
}
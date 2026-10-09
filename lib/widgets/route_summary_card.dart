import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_colors.dart';

class RouteSummaryCard extends StatelessWidget {
  final String destination;
  final String event;
  final String dateRange;

  const RouteSummaryCard({
    super.key,
    required this.destination,
    required this.event,
    required this.dateRange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: AppColors.lightPurple,
        borderRadius: BorderRadius.circular(22),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.location_on_outlined,
                color: AppColors.purple,
                size: 24,
              ),

              const SizedBox(width: 8),

              Expanded(
                child: Text(
                  destination,
                  style: GoogleFonts.quicksand(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: AppColors.darkText,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          Row(
            children: [
              const Icon(
                Icons.confirmation_number_outlined,
                color: AppColors.secondaryText,
                size: 20,
              ),

              const SizedBox(width: 8),

              Expanded(
                child: Text(
                  event,
                  style: GoogleFonts.quicksand(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.darkText,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              const Icon(
                Icons.calendar_month_outlined,
                color: AppColors.secondaryText,
                size: 20,
              ),

              const SizedBox(width: 8),

              Text(
                dateRange,
                style: GoogleFonts.quicksand(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.secondaryText,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
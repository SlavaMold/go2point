import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_colors.dart';

class PriceSummaryCard extends StatelessWidget {
  final String totalPrice;
  final String budgetStatus;
  final bool isWithinBudget;

  const PriceSummaryCard({
    super.key,
    required this.totalPrice,
    required this.budgetStatus,
    this.isWithinBudget = true,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final statuses = Theme.of(context).extension<AppStatusColors>()!;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: scheme.primaryContainer,
        borderRadius: BorderRadius.circular(22),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total price',
            style: GoogleFonts.quicksand(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: scheme.onSurfaceVariant,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            totalPrice,
            style: GoogleFonts.quicksand(
              fontSize: 30,
              fontWeight: FontWeight.w800,
              color: scheme.onSurface,
            ),
          ),

          const SizedBox(height: 14),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),

            decoration: BoxDecoration(
              color: scheme.surface,
              borderRadius: BorderRadius.circular(14),
            ),

            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isWithinBudget
                      ? Icons.check_circle_outline_rounded
                      : Icons.warning_amber_rounded,
                  size: 19,
                  color: isWithinBudget ? scheme.primary : statuses.warning,
                ),

                const SizedBox(width: 7),

                Flexible(
                  child: Text(
                    budgetStatus,
                    style: GoogleFonts.quicksand(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: scheme.onSurface,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

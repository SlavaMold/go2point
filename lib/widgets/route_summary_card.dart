import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    final scheme = Theme.of(context).colorScheme;
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
          Row(
            children: [
              Icon(Icons.location_on_outlined, color: scheme.primary, size: 24),

              const SizedBox(width: 8),

              Expanded(
                child: Text(
                  destination,
                  style: GoogleFonts.quicksand(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: scheme.onSurface,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          Row(
            children: [
              Icon(
                Icons.confirmation_number_outlined,
                color: scheme.onSurfaceVariant,
                size: 20,
              ),

              const SizedBox(width: 8),

              Expanded(
                child: Text(
                  event,
                  style: GoogleFonts.quicksand(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: scheme.onSurface,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              Icon(
                Icons.calendar_month_outlined,
                color: scheme.onSurfaceVariant,
                size: 20,
              ),

              const SizedBox(width: 8),

              Text(
                dateRange,
                style: GoogleFonts.quicksand(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

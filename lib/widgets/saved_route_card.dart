import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_colors.dart';

class SavedRouteCard extends StatelessWidget {
  final String destination;
  final String event;
  final String dateRange;

  final String price;
  final String travelTime;

  final String transportChain;
  final String hotelInfo;

  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onRemove;

  const SavedRouteCard({
    super.key,
    required this.destination,
    required this.event,
    required this.dateRange,
    required this.price,
    required this.travelTime,
    required this.transportChain,
    required this.hotelInfo,
    required this.onTap,
    required this.onEdit,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 10,
      ),

      decoration: BoxDecoration(
        color: AppColors.white,

        borderRadius: BorderRadius.circular(24),

        border: Border.all(
          color: AppColors.lightPurple,
          width: 1.5,
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),

      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(24),

        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(24),

          child: Padding(
            padding: const EdgeInsets.all(20),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // =========================
                // DESTINATION
                // =========================

                Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,

                      decoration: const BoxDecoration(
                        color: AppColors.lightPurple,
                        shape: BoxShape.circle,
                      ),

                      child: const Icon(
                        Icons.location_on_outlined,
                        color: AppColors.purple,
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            destination,
                            style: GoogleFonts.quicksand(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: AppColors.darkText,
                            ),
                          ),

                          const SizedBox(height: 3),

                          Text(
                            event,
                            style: GoogleFonts.quicksand(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.secondaryText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 18),

                // =========================
                // DATE
                // =========================

                Row(
                  children: [
                    const Icon(
                      Icons.calendar_month_outlined,
                      size: 18,
                      color: AppColors.secondaryText,
                    ),

                    const SizedBox(width: 8),

                    Text(
                      dateRange,
                      style: GoogleFonts.quicksand(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.secondaryText,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // =========================
                // PRICE + TIME
                // =========================

                Row(
                  children: [
                    Expanded(
                      child: _MainValue(
                        value: price,
                        label: 'Total price',
                      ),
                    ),

                    Container(
                      width: 1,
                      height: 48,
                      color: AppColors.lightPurple,
                    ),

                    Expanded(
                      child: _MainValue(
                        value: travelTime,
                        label: 'Travel time',
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // =========================
                // TRANSPORT
                // =========================

                _InfoRow(
                  icon: Icons.route_outlined,
                  title: 'Transport',
                  value: transportChain,
                ),

                const SizedBox(height: 15),

                _InfoRow(
                  icon: Icons.hotel_outlined,
                  title: 'Stay',
                  value: hotelInfo,
                ),

                const Spacer(),

                // =========================
                // ACTIONS
                // =========================

                const Divider(
                  color: AppColors.lightPurple,
                ),

                const SizedBox(height: 8),

                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: onEdit,

                        icon: const Icon(
                          Icons.edit_outlined,
                          size: 19,
                        ),

                        label: Text(
                          'Edit',
                          style: GoogleFonts.quicksand(
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.purple,

                          side: const BorderSide(
                            color: AppColors.purple,
                          ),

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: TextButton.icon(
                        onPressed: onRemove,

                        icon: const Icon(
                          Icons.delete_outline_rounded,
                          size: 19,
                        ),

                        label: Text(
                          'Remove',
                          style: GoogleFonts.quicksand(
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        style: TextButton.styleFrom(
                          foregroundColor: Colors.redAccent,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MainValue extends StatelessWidget {
  final String value;
  final String label;

  const _MainValue({
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          textAlign: TextAlign.center,

          style: GoogleFonts.quicksand(
            fontSize: 23,
            fontWeight: FontWeight.w800,
            color: AppColors.darkText,
          ),
        ),

        const SizedBox(height: 4),

        Text(
          label,
          textAlign: TextAlign.center,

          style: GoogleFonts.quicksand(
            fontSize: 12,
            color: AppColors.secondaryText,
          ),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 19,
          color: AppColors.secondaryText,
        ),

        const SizedBox(width: 10),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.quicksand(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.secondaryText,
                ),
              ),

              const SizedBox(height: 2),

              Text(
                value,
                style: GoogleFonts.quicksand(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.darkText,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
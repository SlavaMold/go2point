import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_colors.dart';

enum AlternativeRouteType { cheapest, balanced, luxury }

class AlternativeRouteCard extends StatelessWidget {
  final AlternativeRouteType type;

  final String title;
  final String price;
  final String travelTime;
  final String transportChain;
  final String transfers;
  final String hotelInfo;
  final String budgetDifference;

  final bool isRecommended;

  final VoidCallback onViewRoute;
  final VoidCallback onSave;

  const AlternativeRouteCard({
    super.key,
    required this.type,
    required this.title,
    required this.price,
    required this.travelTime,
    required this.transportChain,
    required this.transfers,
    required this.hotelInfo,
    required this.budgetDifference,
    required this.onViewRoute,
    required this.onSave,
    this.isRecommended = false,
  });

  IconData get routeIcon {
    switch (type) {
      case AlternativeRouteType.cheapest:
        return Icons.savings_outlined;

      case AlternativeRouteType.balanced:
        return Icons.balance_rounded;

      case AlternativeRouteType.luxury:
        return Icons.diamond_outlined;
    }
  }

  String get typeLabel {
    switch (type) {
      case AlternativeRouteType.cheapest:
        return 'CHEAPEST';

      case AlternativeRouteType.balanced:
        return 'BALANCED';

      case AlternativeRouteType.luxury:
        return 'LUXURY';
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final statuses = Theme.of(context).extension<AppStatusColors>()!;
    final borderColor = switch (type) {
      AlternativeRouteType.cheapest => statuses.success,
      AlternativeRouteType.balanced => statuses.warning,
      AlternativeRouteType.luxury => scheme.primary,
    };
    final foregroundColor = switch (type) {
      AlternativeRouteType.cheapest => statuses.onSuccess,
      AlternativeRouteType.balanced => statuses.onWarning,
      AlternativeRouteType.luxury => scheme.onPrimary,
    };
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),

      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: scheme.surface,

        borderRadius: BorderRadius.circular(24),

        border: Border.all(color: borderColor, width: 2),

        boxShadow: [
          BoxShadow(
            color: scheme.shadow.withValues(alpha: 0.04),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),

      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER
            Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: borderColor.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(routeIcon, color: borderColor),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        typeLabel,
                        style: GoogleFonts.quicksand(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.2,
                          color: borderColor,
                        ),
                      ),

                      const SizedBox(height: 2),

                      Text(
                        title,
                        style: GoogleFonts.quicksand(
                          fontSize: 19,
                          fontWeight: FontWeight.w800,
                          color: scheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),

                if (isRecommended)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: scheme.primaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Recommended',
                      style: GoogleFonts.quicksand(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: scheme.primary,
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 24),

            // PRICE + TIME
            Row(
              children: [
                Expanded(
                  child: _MainValue(label: 'Total price', value: price),
                ),

                Container(width: 1, height: 48, color: scheme.primaryContainer),

                Expanded(
                  child: _MainValue(label: 'Travel time', value: travelTime),
                ),
              ],
            ),

            const SizedBox(height: 24),

            _InfoRow(
              icon: Icons.route_outlined,
              title: 'Transport',
              value: transportChain,
            ),

            const SizedBox(height: 14),

            _InfoRow(
              icon: Icons.sync_alt_rounded,
              title: 'Transfers',
              value: transfers,
            ),

            const SizedBox(height: 14),

            _InfoRow(
              icon: Icons.hotel_outlined,
              title: 'Stay',
              value: hotelInfo,
            ),

            const SizedBox(height: 22),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: borderColor.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                budgetDifference,
                style: GoogleFonts.quicksand(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: scheme.onSurface,
                ),
              ),
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: onViewRoute,
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: borderColor,
                  foregroundColor: foregroundColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  'View route',
                  style: GoogleFonts.quicksand(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              child: TextButton.icon(
                onPressed: onSave,
                icon: const Icon(Icons.bookmark_border_rounded),
                label: Text(
                  'Save route',
                  style: GoogleFonts.quicksand(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                style: TextButton.styleFrom(foregroundColor: scheme.onSurface),
              ),
            ),

            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}

class _MainValue extends StatelessWidget {
  final String label;
  final String value;

  const _MainValue({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        Text(
          value,
          textAlign: TextAlign.center,

          style: GoogleFonts.quicksand(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: scheme.onSurface,
          ),
        ),

        const SizedBox(height: 4),

        Text(
          label,
          textAlign: TextAlign.center,

          style: GoogleFonts.quicksand(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: scheme.onSurfaceVariant,
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
    final scheme = Theme.of(context).colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: scheme.onSurfaceVariant),

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
                  color: scheme.onSurfaceVariant,
                ),
              ),

              const SizedBox(height: 2),

              Text(
                value,
                style: GoogleFonts.quicksand(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: scheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    final scheme = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),

      decoration: BoxDecoration(
        color: scheme.surface,

        borderRadius: BorderRadius.circular(24),

        border: Border.all(color: scheme.primaryContainer, width: 1.5),

        boxShadow: [
          BoxShadow(
            color: scheme.shadow.withValues(alpha: 0.04),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),

      child: Material(
        color: scheme.surface.withValues(alpha: 0),
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

                      decoration: BoxDecoration(
                        color: scheme.primaryContainer,
                        shape: BoxShape.circle,
                      ),

                      child: Icon(
                        Icons.location_on_outlined,
                        color: scheme.primary,
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
                              color: scheme.onSurface,
                            ),
                          ),

                          const SizedBox(height: 3),

                          Text(
                            event,
                            style: GoogleFonts.quicksand(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: scheme.onSurfaceVariant,
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
                    Icon(
                      Icons.calendar_month_outlined,
                      size: 18,
                      color: scheme.onSurfaceVariant,
                    ),

                    const SizedBox(width: 8),

                    Text(
                      dateRange,
                      style: GoogleFonts.quicksand(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: scheme.onSurfaceVariant,
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
                      child: _MainValue(value: price, label: 'Total price'),
                    ),

                    Container(
                      width: 1,
                      height: 48,
                      color: scheme.primaryContainer,
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
                Divider(color: scheme.primaryContainer),

                const SizedBox(height: 8),

                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: onEdit,

                        icon: const Icon(Icons.edit_outlined, size: 19),

                        label: Text(
                          'Edit',
                          style: GoogleFonts.quicksand(
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        style: OutlinedButton.styleFrom(
                          foregroundColor: scheme.primary,

                          side: BorderSide(color: scheme.primary),

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
                          foregroundColor: scheme.error,
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

  const _MainValue({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        Text(
          value,
          textAlign: TextAlign.center,

          style: GoogleFonts.quicksand(
            fontSize: 23,
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
        Icon(icon, size: 19, color: scheme.onSurfaceVariant),

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

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_text_field.dart';

class EditableRouteStepCard extends StatelessWidget {
  final IconData icon;
  final String title;

  final TextEditingController fromController;
  final TextEditingController toController;
  final TextEditingController priceController;

  final TextEditingController? departureDateController;
  final TextEditingController? arrivalDateController;

  final VoidCallback? onDepartureDateTap;
  final VoidCallback? onArrivalDateTap;

  const EditableRouteStepCard({
    super.key,
    required this.icon,
    required this.title,
    required this.fromController,
    required this.toController,
    required this.priceController,
    this.departureDateController,
    this.arrivalDateController,
    this.onDepartureDateTap,
    this.onArrivalDateTap,
  });

  bool get hasDepartureDate => departureDateController != null;

  bool get hasArrivalDate => arrivalDateController != null;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(22),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // =========================
          // HEADER
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

                child: Icon(icon, color: scheme.primary),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.quicksand(
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                    color: scheme.onSurface,
                  ),
                ),
              ),

              Icon(
                Icons.edit_outlined,
                color: scheme.onSurfaceVariant,
                size: 20,
              ),
            ],
          ),

          const SizedBox(height: 22),

          // =========================
          // FROM
          // =========================
          AppTextField(
            label: 'From',
            hint: 'Departure point',
            prefixIcon: Icons.trip_origin_rounded,
            controller: fromController,
          ),

          const SizedBox(height: 18),

          // =========================
          // TO
          // =========================
          AppTextField(
            label: 'To',
            hint: 'Destination point',
            prefixIcon: Icons.location_on_outlined,
            controller: toController,
          ),

          // =========================
          // OPTIONAL DATES
          // =========================
          if (hasDepartureDate || hasArrivalDate) ...[
            const SizedBox(height: 18),

            Row(
              children: [
                if (hasDepartureDate)
                  Expanded(
                    child: AppTextField(
                      label: 'Departure',
                      hint: 'dd/mm/yyyy',
                      prefixIcon: Icons.calendar_month_outlined,
                      controller: departureDateController,
                      readOnly: true,
                      onTap: onDepartureDateTap,
                    ),
                  ),

                if (hasDepartureDate && hasArrivalDate)
                  const SizedBox(width: 12),

                if (hasArrivalDate)
                  Expanded(
                    child: AppTextField(
                      label: 'Arrival',
                      hint: 'dd/mm/yyyy',
                      prefixIcon: Icons.calendar_month_outlined,
                      controller: arrivalDateController,
                      readOnly: true,
                      onTap: onArrivalDateTap,
                    ),
                  ),
              ],
            ),
          ],

          const SizedBox(height: 18),

          // =========================
          // PRICE
          // =========================
          AppTextField(
            label: 'Price',
            hint: '0',
            prefixText: '€ ',
            prefixIcon: Icons.payments_outlined,
            controller: priceController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d*[.,]?\d{0,2}')),
            ],
          ),
        ],
      ),
    );
  }
}

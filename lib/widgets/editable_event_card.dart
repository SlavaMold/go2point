import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_colors.dart';
import 'app_text_field.dart';

class EditableEventCard extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController addressController;
  final TextEditingController dateController;
  final TextEditingController priceController;

  final VoidCallback onDateTap;

  const EditableEventCard({
    super.key,
    required this.nameController,
    required this.addressController,
    required this.dateController,
    required this.priceController,
    required this.onDateTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: AppColors.fieldBackground,
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

                decoration: const BoxDecoration(
                  color: AppColors.lightPurple,
                  shape: BoxShape.circle,
                ),

                child: const Icon(
                  Icons.confirmation_number_outlined,
                  color: AppColors.purple,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Text(
                  'Event',
                  style: GoogleFonts.quicksand(
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                    color: AppColors.darkText,
                  ),
                ),
              ),

              const Icon(
                Icons.edit_outlined,
                color: AppColors.secondaryText,
                size: 20,
              ),
            ],
          ),

          const SizedBox(height: 22),

          // =========================
          // EVENT NAME
          // =========================

          AppTextField(
            label: 'Event name',
            hint: 'Enter event name',
            prefixIcon: Icons.event_outlined,
            controller: nameController,
          ),

          const SizedBox(height: 18),

          // =========================
          // EVENT ADDRESS
          // =========================

          AppTextField(
            label: 'Event address',
            hint: 'Enter event address',
            prefixIcon: Icons.location_on_outlined,
            controller: addressController,
          ),

          const SizedBox(height: 18),

          // =========================
          // EVENT DATE
          // =========================

          AppTextField(
            label: 'Event date',
            hint: 'dd/mm/yyyy',
            prefixIcon: Icons.calendar_month_outlined,
            suffixIcon: Icons.calendar_today_outlined,
            controller: dateController,
            readOnly: true,
            onTap: onDateTap,
          ),

          const SizedBox(height: 18),

          // =========================
          // TICKET PRICE
          // =========================

          AppTextField(
            label: 'Ticket price',
            hint: '0',
            prefixText: '€ ',
            prefixIcon: Icons.payments_outlined,
            controller: priceController,

            keyboardType: const TextInputType.numberWithOptions(
              decimal: true,
            ),

            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'^\d*[.,]?\d{0,2}'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
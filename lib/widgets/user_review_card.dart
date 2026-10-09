import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_colors.dart';

class UserReviewCard extends StatelessWidget {
  final String destination;
  final String routeTitle;
  final int rating;
  final String reviewText;
  final String date;

  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const UserReviewCard({
    super.key,
    required this.destination,
    required this.routeTitle,
    required this.rating,
    required this.reviewText,
    required this.date,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: AppColors.fieldBackground,
        borderRadius: BorderRadius.circular(20),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.location_on_outlined,
                color: AppColors.purple,
              ),

              const SizedBox(width: 8),

              Expanded(
                child: Text(
                  destination,
                  style: GoogleFonts.quicksand(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: AppColors.darkText,
                  ),
                ),
              ),

              Text(
                date,
                style: GoogleFonts.quicksand(
                  fontSize: 12,
                  color: AppColors.secondaryText,
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          Text(
            routeTitle,
            style: GoogleFonts.quicksand(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.secondaryText,
            ),
          ),

          const SizedBox(height: 12),

          Row(
            children: List.generate(
              5,
              (index) {
                return Icon(
                  index < rating
                      ? Icons.star_rounded
                      : Icons.star_border_rounded,
                  size: 20,
                  color: Colors.amber,
                );
              },
            ),
          ),

          const SizedBox(height: 12),

          Text(
            reviewText,
            style: GoogleFonts.quicksand(
              fontSize: 14,
              height: 1.5,
              color: AppColors.darkText,
            ),
          ),

          const SizedBox(height: 14),

          const Divider(
            color: AppColors.lightPurple,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton.icon(
                onPressed: onEdit,
                icon: const Icon(
                  Icons.edit_outlined,
                  size: 18,
                ),
                label: const Text('Edit'),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.purple,
                ),
              ),

              TextButton.icon(
                onPressed: onDelete,
                icon: const Icon(
                  Icons.delete_outline_rounded,
                  size: 18,
                ),
                label: const Text('Delete'),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.redAccent,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
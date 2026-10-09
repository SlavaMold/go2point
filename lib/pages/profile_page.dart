import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_colors.dart';
import '../widgets/user_review_card.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,

      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,

        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.darkText,
          ),
        ),

        title: Text(
          'Profile',
          style: GoogleFonts.quicksand(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppColors.darkText,
          ),
        ),

        centerTitle: true,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            24,
            20,
            24,
            35,
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // =========================
              // PROFILE HEADER
              // =========================

              Center(
                child: Column(
                  children: [
                    Container(
                      width: 92,
                      height: 92,

                      decoration: const BoxDecoration(
                        color: AppColors.lightPurple,
                        shape: BoxShape.circle,
                      ),

                      child: const Icon(
                        Icons.person_rounded,
                        size: 48,
                        color: AppColors.purple,
                      ),
                    ),

                    const SizedBox(height: 14),

                    Text(
                      'Slava Todorov',
                      style: GoogleFonts.quicksand(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: AppColors.darkText,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      'slava@example.com',
                      style: GoogleFonts.quicksand(
                        fontSize: 14,
                        color: AppColors.secondaryText,
                      ),
                    ),

                    const SizedBox(height: 18),

                    OutlinedButton.icon(
                      onPressed: () {},

                      icon: const Icon(
                        Icons.edit_outlined,
                      ),

                      label: Text(
                        'Edit profile',
                        style: GoogleFonts.quicksand(
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.purple,

                        side: const BorderSide(
                          color: AppColors.purple,
                        ),

                        padding: const EdgeInsets.symmetric(
                          horizontal: 22,
                          vertical: 13,
                        ),

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // =========================
              // STATISTICS
              // =========================

              Row(
                children: [
                  Expanded(
                    child: _ProfileStatCard(
                      icon: Icons.bookmark_outline_rounded,
                      value: '4',
                      label: 'Saved routes',
                    ),
                  ),

                  const SizedBox(width: 14),

                  Expanded(
                    child: _ProfileStatCard(
                      icon: Icons.rate_review_outlined,
                      value: '2',
                      label: 'Reviews',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 34),

              // =========================
              // REVIEWS
              // =========================

              Text(
                'Your reviews',
                style: GoogleFonts.quicksand(
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                  color: AppColors.darkText,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Reviews you left after your journeys.',
                style: GoogleFonts.quicksand(
                  fontSize: 14,
                  color: AppColors.secondaryText,
                ),
              ),

              const SizedBox(height: 18),

              UserReviewCard(
                destination: 'Budapest, Hungary',
                routeTitle: 'Balanced route',
                rating: 5,
                reviewText:
                    'Everything was well balanced. The flight was convenient and the hotel was close to the event.',
                date: '18/10/2026',
                onEdit: () {},
                onDelete: () {},
              ),

              const SizedBox(height: 16),

              UserReviewCard(
                destination: 'Bucharest, Romania',
                routeTitle: 'Cheapest route',
                rating: 4,
                reviewText:
                    'Good option for the price. The journey took longer than expected, but overall it was worth it.',
                date: '09/08/2026',
                onEdit: () {},
                onDelete: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileStatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _ProfileStatCard({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 14,
      ),

      decoration: BoxDecoration(
        color: AppColors.fieldBackground,
        borderRadius: BorderRadius.circular(18),
      ),

      child: Column(
        children: [
          Icon(
            icon,
            color: AppColors.purple,
            size: 25,
          ),

          const SizedBox(height: 8),

          Text(
            value,
            style: GoogleFonts.quicksand(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppColors.darkText,
            ),
          ),

          const SizedBox(height: 2),

          Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.quicksand(
              fontSize: 12,
              color: AppColors.secondaryText,
            ),
          ),
        ],
      ),
    );
  }
}
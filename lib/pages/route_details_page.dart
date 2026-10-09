import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_colors.dart';
import '../widgets/app_button.dart';
import '../widgets/price_summary_card.dart';
import '../widgets/route_step_card.dart';
import '../widgets/route_summary_card.dart';

class RouteDetailsPage extends StatelessWidget {
  const RouteDetailsPage({super.key});

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
          'Your route',
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
              Text(
                'Your trip is ready',
                style: GoogleFonts.quicksand(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  color: AppColors.darkText,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Here is the route we prepared around your event.',
                style: GoogleFonts.quicksand(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: AppColors.secondaryText,
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 28),

              // -------------------------
              // ROUTE SUMMARY
              // -------------------------

              const RouteSummaryCard(
                destination: 'Budapest, Hungary',
                event: 'Metallica concert',
                dateRange: '13/10/2026 — 16/10/2026',
              ),

              const SizedBox(height: 32),

              Text(
                'Journey details',
                style: GoogleFonts.quicksand(
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                  color: AppColors.darkText,
                ),
              ),

              const SizedBox(height: 18),

              // -------------------------
              // FLIGHT
              // -------------------------

              const RouteStepCard(
                icon: Icons.flight_takeoff_rounded,
                title: 'Flight',
                subtitle: 'Chisinau → Budapest',
                price: '€145',
              ),

              const _RouteConnector(),

              // -------------------------
              // AIRPORT TRANSFER
              // -------------------------

              const RouteStepCard(
                icon: Icons.directions_bus_outlined,
                title: 'Airport transfer',
                subtitle: 'Budapest Airport → City center',
                price: '€12',
              ),

              const _RouteConnector(),

              // -------------------------
              // HOTEL
              // -------------------------

              const RouteStepCard(
                icon: Icons.hotel_outlined,
                title: 'Hotel',
                subtitle: '3 nights · 1.4 km from event',
                price: '€198',
              ),

              const _RouteConnector(),

              // -------------------------
              // EVENT
              // -------------------------

              const RouteStepCard(
                icon: Icons.confirmation_number_outlined,
                title: 'Event ticket',
                subtitle: 'Metallica · Budapest Arena',
                price: '€85',
              ),

              const _RouteConnector(),

              // -------------------------
              // LOCAL TRANSPORT
              // -------------------------

              const RouteStepCard(
                icon: Icons.directions_subway_outlined,
                title: 'Local transport',
                subtitle: 'Hotel ↔ Event + city transport',
                price: '€25',
              ),

              const _RouteConnector(),

              // -------------------------
              // RETURN TO AIRPORT
              // -------------------------

              const RouteStepCard(
                icon: Icons.airport_shuttle_outlined,
                title: 'Return to airport',
                subtitle: 'City center → Budapest Airport',
                price: '€12',
              ),

              const SizedBox(height: 32),

              Text(
                'Budget',
                style: GoogleFonts.quicksand(
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                  color: AppColors.darkText,
                ),
              ),

              const SizedBox(height: 16),

              const PriceSummaryCard(
                totalPrice: '€477',
                budgetStatus: 'Within your budget',
                isWithinBudget: true,
              ),

              const SizedBox(height: 32),

              // -------------------------
              // ACTIONS
              // -------------------------

              AppButton(
                text: 'Save route',
                icon: Icons.bookmark_border_rounded,
                onPressed: () {},
              ),

              const SizedBox(height: 14),

              SizedBox(
                width: double.infinity,
                height: 58,
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.darkText,
                    side: const BorderSide(
                      color: AppColors.purple,
                      width: 1.5,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.alt_route_rounded,
                        color: AppColors.purple,
                      ),

                      const SizedBox(width: 10),

                      Text(
                        'See alternatives',
                        style: GoogleFonts.quicksand(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: AppColors.darkText,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 14),

              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  minimumSize: const Size(
                    double.infinity,
                    50,
                  ),
                ),
                child: Text(
                  'Edit route',
                  style: GoogleFonts.quicksand(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.purple,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.purple,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Маленький визуальный соединитель между этапами маршрута.
// Пока это просто UI-элемент.
class _RouteConnector extends StatelessWidget {
  const _RouteConnector();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(
        left: 39,
        top: 5,
        bottom: 5,
      ),
      child: SizedBox(
        height: 24,
        child: VerticalDivider(
          thickness: 2,
          width: 2,
          color: AppColors.lightPurple,
        ),
      ),
    );
  }
}
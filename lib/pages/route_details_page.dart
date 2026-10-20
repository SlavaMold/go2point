import 'package:flutter/material.dart';

import '../widgets/app_feedback.dart';

import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/mock_routes.dart';
import '../models/trip_route.dart';
import 'not_found_page.dart';
import '../widgets/app_button.dart';
import '../widgets/price_summary_card.dart';
import '../widgets/route_step_card.dart';
import '../widgets/route_summary_card.dart';

class RouteDetailsPage extends StatelessWidget {
  final int id;

  const RouteDetailsPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final trip = findMockRoute(id);
    if (trip == null) {
      return NotFoundPage(message: 'Trip $id was not found.');
    }
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: scheme.surface,

      appBar: AppBar(
        backgroundColor: scheme.surface,
        elevation: 0,

        title: Text(
          'Your route',
          style: GoogleFonts.quicksand(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: scheme.onSurface,
          ),
        ),

        centerTitle: true,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 35),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your trip is ready',
                style: GoogleFonts.quicksand(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  color: scheme.onSurface,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Here is the route we prepared around your event.',
                style: GoogleFonts.quicksand(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: scheme.onSurfaceVariant,
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 28),

              // -------------------------
              // ROUTE SUMMARY
              // -------------------------
              RouteSummaryCard(
                destination: trip.destination,
                event: trip.event.from,
                dateRange: trip.dateRange,
              ),

              const SizedBox(height: 32),

              Text(
                'Journey details',
                style: GoogleFonts.quicksand(
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                  color: scheme.onSurface,
                ),
              ),

              const SizedBox(height: 18),

              for (final (index, step) in trip.steps.indexed) ...[
                if (index > 0) const _RouteConnector(),
                RouteStepCard(
                  icon: _stepIcon(step.kind),
                  title: step.title,
                  subtitle: step.description,
                  price: formatEuro(step.price),
                ),
              ],

              const SizedBox(height: 32),

              Text(
                'Budget',
                style: GoogleFonts.quicksand(
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                  color: scheme.onSurface,
                ),
              ),

              const SizedBox(height: 16),

              PriceSummaryCard(
                totalPrice: formatEuro(trip.totalPrice),
                budgetStatus: trip.isWithinBudget
                    ? 'Within your budget'
                    : 'Over your budget',
                isWithinBudget: trip.isWithinBudget,
              ),

              const SizedBox(height: 32),

              // -------------------------
              // ACTIONS
              // -------------------------
              AppButton(
                text: 'Save route',
                icon: Icons.bookmark_border_rounded,
                onPressed: () => showAppMessage(
                  context,
                  'Save confirmed. Demo data is unchanged.',
                ),
              ),

              const SizedBox(height: 14),

              SizedBox(
                width: double.infinity,
                height: 58,
                child: OutlinedButton(
                  onPressed: () => context.go('/plan/alternatives'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: scheme.onSurface,
                    side: BorderSide(color: scheme.primary, width: 1.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.alt_route_rounded, color: scheme.primary),

                      const SizedBox(width: 10),

                      Text(
                        'See alternatives',
                        style: GoogleFonts.quicksand(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: scheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 14),

              TextButton(
                onPressed: () =>
                    context.push('${GoRouterState.of(context).uri.path}/edit'),
                style: TextButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: Text(
                  'Edit route',
                  style: GoogleFonts.quicksand(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: scheme.primary,
                    decoration: TextDecoration.underline,
                    decorationColor: scheme.primary,
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
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.only(left: 39, top: 5, bottom: 5),
      child: SizedBox(
        height: 24,
        child: VerticalDivider(
          thickness: 2,
          width: 2,
          color: scheme.primaryContainer,
        ),
      ),
    );
  }
}

IconData _stepIcon(TripStepKind kind) => switch (kind) {
  TripStepKind.flight => Icons.flight_takeoff_rounded,
  TripStepKind.train => Icons.train_outlined,
  TripStepKind.transfer => Icons.directions_bus_outlined,
  TripStepKind.hotel => Icons.hotel_outlined,
  TripStepKind.event => Icons.confirmation_number_outlined,
  TripStepKind.localTransport => Icons.directions_subway_outlined,
  TripStepKind.returnTransfer => Icons.airport_shuttle_outlined,
};

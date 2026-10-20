import 'package:flutter/material.dart';

import '../widgets/app_feedback.dart';

import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/mock_routes.dart';
import '../models/trip_route.dart';
import '../widgets/alternative_route_card.dart';
import '../widgets/route_summary_card.dart';

class AlternativeRoutesPage extends StatefulWidget {
  const AlternativeRoutesPage({super.key});

  @override
  State<AlternativeRoutesPage> createState() => _AlternativeRoutesPageState();
}

class _AlternativeRoutesPageState extends State<AlternativeRoutesPage> {
  final PageController _pageController = PageController(viewportFraction: 0.88);

  int _currentPage = 1;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _pageController.jumpToPage(1);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final summary = mockAlternativeRoutes.firstWhere(
      (trip) => trip.isRecommended,
    );
    return Scaffold(
      backgroundColor: scheme.surface,

      appBar: AppBar(
        backgroundColor: scheme.surface,
        elevation: 0,

        title: Text(
          'Alternative routes',
          style: GoogleFonts.quicksand(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: scheme.onSurface,
          ),
        ),

        centerTitle: true,
      ),

      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Choose your way',
                    style: GoogleFonts.quicksand(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      color: scheme.onSurface,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    'Compare price, travel time and comfort before saving your route.',
                    style: GoogleFonts.quicksand(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: scheme.onSurfaceVariant,
                      height: 1.4,
                    ),
                  ),

                  const SizedBox(height: 24),

                  RouteSummaryCard(
                    destination: summary.destination,
                    event: summary.event.from,
                    dateRange: summary.dateRange,
                  ),

                  const SizedBox(height: 18),

                  Row(
                    children: [
                      Icon(
                        Icons.swipe_rounded,
                        size: 18,
                        color: scheme.onSurfaceVariant,
                      ),

                      const SizedBox(width: 8),

                      Text(
                        'Swipe to compare routes',
                        style: GoogleFonts.quicksand(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            Expanded(
              child: PageView.builder(
                controller: _pageController,

                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },

                itemCount: mockAlternativeRoutes.length,
                itemBuilder: (context, index) {
                  final trip = mockAlternativeRoutes[index];
                  return AlternativeRouteCard(
                    type: switch (trip.category) {
                      TripRouteCategory.cheapest =>
                        AlternativeRouteType.cheapest,
                      TripRouteCategory.balanced =>
                        AlternativeRouteType.balanced,
                      TripRouteCategory.luxury => AlternativeRouteType.luxury,
                    },
                    title: trip.title,
                    price: formatEuro(trip.totalPrice),
                    travelTime: trip.travelTime,
                    transportChain: trip.transportChain,
                    transfers: trip.transfers,
                    hotelInfo: trip.hotelInfo,
                    budgetDifference: trip.budgetDifference,
                    isRecommended: trip.isRecommended,
                    onViewRoute: () =>
                        context.push('/plan/alternatives/${trip.id}'),
                    onSave: () => showAppMessage(
                      context,
                      'Save confirmed. Demo data is unchanged.',
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 8),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(mockAlternativeRoutes.length, (index) {
                final isActive = index == _currentPage;

                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),

                  margin: const EdgeInsets.symmetric(horizontal: 4),

                  width: isActive ? 22 : 8,
                  height: 8,

                  decoration: BoxDecoration(
                    color: isActive ? scheme.primary : scheme.primaryContainer,

                    borderRadius: BorderRadius.circular(10),
                  ),
                );
              }),
            ),

            const SizedBox(height: 14),
          ],
        ),
      ),
    );
  }
}

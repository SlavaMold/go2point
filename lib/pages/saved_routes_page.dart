import 'package:flutter/material.dart';

import '../widgets/app_feedback.dart';

import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/mock_routes.dart';
import '../models/trip_route.dart';
import '../widgets/saved_route_card.dart';

class SavedRoutesPage extends StatefulWidget {
  const SavedRoutesPage({super.key});

  @override
  State<SavedRoutesPage> createState() => _SavedRoutesPageState();
}

class _SavedRoutesPageState extends State<SavedRoutesPage> {
  final PageController _pageController = PageController(viewportFraction: 0.88);

  int _currentPage = 0;

  int get _routesCount => mockSavedRoutes.length;

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: scheme.surface,

      appBar: AppBar(
        backgroundColor: scheme.surface,
        elevation: 0,

        title: Text(
          'Saved routes',
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
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 12),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your journeys',
                    style: GoogleFonts.quicksand(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      color: scheme.onSurface,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    'Your saved travel plans are always here when you need them.',
                    style: GoogleFonts.quicksand(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: scheme.onSurfaceVariant,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Stack(
                children: [
                  // =========================
                  // VERTICAL ROUTE HISTORY
                  // =========================

                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 38),

                    child: PageView.builder(
                      controller: _pageController,

                      scrollDirection: Axis.vertical,

                      onPageChanged: (index) {
                        setState(() {
                          _currentPage = index;
                        });
                      },

                      itemCount: mockSavedRoutes.length,
                      itemBuilder: (context, index) {
                        final trip = mockSavedRoutes[index];
                        return SavedRouteCard(
                          destination: trip.destination,
                          event: trip.event.from,
                          dateRange: trip.dateRange,
                          price: formatEuro(trip.totalPrice),
                          travelTime: trip.travelTime,
                          transportChain: trip.transportChain,
                          hotelInfo: trip.hotelInfo,
                          onTap: () => context.push('/saved/${trip.id}'),
                          onEdit: () => context.push('/saved/${trip.id}/edit'),
                          onRemove: () => confirmDemoRemoval(
                            context,
                            'route to ${trip.city}',
                          ),
                        );
                      },
                    ),
                  ),

                  // =========================
                  // PAGE INDICATOR
                  // =========================
                  Positioned(
                    right: 12,
                    top: 0,
                    bottom: 0,

                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,

                        children: List.generate(_routesCount, (index) {
                          final isActive = index == _currentPage;

                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 200),

                            margin: const EdgeInsets.symmetric(vertical: 4),

                            width: 8,

                            height: isActive ? 22 : 8,

                            decoration: BoxDecoration(
                              color: isActive
                                  ? scheme.primary
                                  : scheme.primaryContainer,

                              borderRadius: BorderRadius.circular(10),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),
          ],
        ),
      ),
    );
  }
}

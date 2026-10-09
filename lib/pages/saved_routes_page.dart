import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_colors.dart';
import '../widgets/saved_route_card.dart';

class SavedRoutesPage extends StatefulWidget {
  const SavedRoutesPage({super.key});

  @override
  State<SavedRoutesPage> createState() =>
      _SavedRoutesPageState();
}

class _SavedRoutesPageState extends State<SavedRoutesPage> {
  final PageController _pageController = PageController(
    viewportFraction: 0.88,
  );

  int _currentPage = 0;

  final int _routesCount = 4;

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

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
          'Saved routes',
          style: GoogleFonts.quicksand(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppColors.darkText,
          ),
        ),

        centerTitle: true,
      ),

      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                24,
                20,
                24,
                12,
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your journeys',
                    style: GoogleFonts.quicksand(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      color: AppColors.darkText,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    'Your saved travel plans are always here when you need them.',
                    style: GoogleFonts.quicksand(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: AppColors.secondaryText,
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
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 38,
                    ),

                    child: PageView(
                      controller: _pageController,

                      scrollDirection: Axis.vertical,

                      onPageChanged: (index) {
                        setState(() {
                          _currentPage = index;
                        });
                      },

                      children: [
                        SavedRouteCard(
                          destination: 'Budapest, Hungary',
                          event: 'Metallica concert',
                          dateRange:
                              '13/10/2026 — 16/10/2026',
                          price: '€575',
                          travelTime: '5 h 20 min',
                          transportChain:
                              'Direct flight → Metro',
                          hotelInfo:
                              '3★ hotel · 3 nights',
                          onTap: () {},
                          onEdit: () {},
                          onRemove: () {},
                        ),

                        SavedRouteCard(
                          destination: 'Bucharest, Romania',
                          event: 'Rock Festival',
                          dateRange:
                              '04/08/2026 — 07/08/2026',
                          price: '€310',
                          travelTime: '7 h 15 min',
                          transportChain:
                              'Train → Taxi',
                          hotelInfo:
                              '3★ hotel · 3 nights',
                          onTap: () {},
                          onEdit: () {},
                          onRemove: () {},
                        ),

                        SavedRouteCard(
                          destination: 'Vienna, Austria',
                          event: 'Art Exhibition',
                          dateRange:
                              '21/11/2026 — 25/11/2026',
                          price: '€690',
                          travelTime: '4 h 10 min',
                          transportChain:
                              'Flight → Airport train',
                          hotelInfo:
                              '4★ hotel · 4 nights',
                          onTap: () {},
                          onEdit: () {},
                          onRemove: () {},
                        ),

                        SavedRouteCard(
                          destination: 'Prague, Czech Republic',
                          event: 'Music Festival',
                          dateRange:
                              '02/06/2027 — 06/06/2027',
                          price: '€520',
                          travelTime: '6 h 05 min',
                          transportChain:
                              'Flight → Bus → Tram',
                          hotelInfo:
                              '3★ hotel · 4 nights',
                          onTap: () {},
                          onEdit: () {},
                          onRemove: () {},
                        ),
                      ],
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

                        children: List.generate(
                          _routesCount,
                          (index) {
                            final isActive =
                                index == _currentPage;

                            return AnimatedContainer(
                              duration: const Duration(
                                milliseconds: 200,
                              ),

                              margin:
                                  const EdgeInsets.symmetric(
                                vertical: 4,
                              ),

                              width: 8,

                              height: isActive ? 22 : 8,

                              decoration: BoxDecoration(
                                color: isActive
                                    ? AppColors.purple
                                    : AppColors.lightPurple,

                                borderRadius:
                                    BorderRadius.circular(10),
                              ),
                            );
                          },
                        ),
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
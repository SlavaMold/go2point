import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_colors.dart';
import '../widgets/alternative_route_card.dart';
import '../widgets/route_summary_card.dart';

class AlternativeRoutesPage extends StatefulWidget {
  const AlternativeRoutesPage({super.key});

  @override
  State<AlternativeRoutesPage> createState() =>
      _AlternativeRoutesPageState();
}

class _AlternativeRoutesPageState
    extends State<AlternativeRoutesPage> {
  final PageController _pageController = PageController(
    viewportFraction: 0.88,
  );

  int _currentPage = 1;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pageController.jumpToPage(1);
    });
  }

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
          'Alternative routes',
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
                0,
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Choose your way',
                    style: GoogleFonts.quicksand(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      color: AppColors.darkText,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    'Compare price, travel time and comfort before saving your route.',
                    style: GoogleFonts.quicksand(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: AppColors.secondaryText,
                      height: 1.4,
                    ),
                  ),

                  const SizedBox(height: 24),

                  const RouteSummaryCard(
                    destination: 'Budapest, Hungary',
                    event: 'Metallica concert',
                    dateRange: '13/10/2026 — 16/10/2026',
                  ),

                  const SizedBox(height: 18),

                  Row(
                    children: [
                      const Icon(
                        Icons.swipe_rounded,
                        size: 18,
                        color: AppColors.secondaryText,
                      ),

                      const SizedBox(width: 8),

                      Text(
                        'Swipe to compare routes',
                        style: GoogleFonts.quicksand(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.secondaryText,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            Expanded(
              child: PageView(
                controller: _pageController,

                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },

                children: [
                  AlternativeRouteCard(
                    type: AlternativeRouteType.cheapest,

                    title: 'Save as much as possible',

                    price: '€398',

                    travelTime: '11 h 40 min',

                    transportChain:
                        'Train → Bus → Metro',

                    transfers: '2 transfers',

                    hotelInfo:
                        'Budget hotel · 2 nights',

                    budgetDifference:
                        '€202 under your €600 budget',

                    onViewRoute: () {},

                    onSave: () {},
                  ),

                  AlternativeRouteCard(
                    type: AlternativeRouteType.balanced,

                    title: 'Best price-time balance',

                    price: '€575',

                    travelTime: '5 h 20 min',

                    transportChain:
                        'Direct flight → Metro',

                    transfers: '1 transfer',

                    hotelInfo:
                        '3★ hotel · 3 nights',

                    budgetDifference:
                        'Best match for your €600 budget',

                    isRecommended: true,

                    onViewRoute: () {},

                    onSave: () {},
                  ),

                  AlternativeRouteCard(
                    type: AlternativeRouteType.luxury,

                    title: 'Fastest and most comfortable',

                    price: '€860',

                    travelTime: '3 h 45 min',

                    transportChain:
                        'Direct flight → Private taxi',

                    transfers: 'No public transport transfers',

                    hotelInfo:
                        '4★ hotel · 3 nights',

                    budgetDifference:
                        '€260 over your €600 budget',

                    onViewRoute: () {},

                    onSave: () {},
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (index) {
                  final isActive =
                      index == _currentPage;

                  return AnimatedContainer(
                    duration:
                        const Duration(milliseconds: 200),

                    margin:
                        const EdgeInsets.symmetric(horizontal: 4),

                    width: isActive ? 22 : 8,
                    height: 8,

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

            const SizedBox(height: 14),
          ],
        ),
      ),
    );
  }
}
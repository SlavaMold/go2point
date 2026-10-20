import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:go_router/go_router.dart';

import '../widgets/app_feedback.dart';
import '../widgets/app_logo.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _selectedLanguage = 'EN';

  final List<String> _languages = ['EN', 'RO', 'RU'];

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: scheme.surface,

      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),

            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: (constraints.maxHeight - 36).clamp(
                  0.0,
                  double.infinity,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // =========================
                  // HEADER
                  // =========================

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Flexible(
                        child: FittedBox(
                          child: AppLogo(fontSize: 23, iconSize: 31),
                        ),
                      ),
                      const SizedBox(width: 12),

                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),

                        decoration: BoxDecoration(
                          color: scheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(14),
                        ),

                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedLanguage,

                            icon: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: scheme.onSurface,
                            ),

                            style: GoogleFonts.quicksand(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: scheme.onSurface,
                            ),

                            dropdownColor: scheme.surface,

                            borderRadius: BorderRadius.circular(14),

                            items: _languages.map((language) {
                              return DropdownMenuItem<String>(
                                value: language,
                                child: Row(
                                  children: [
                                    Text(
                                      _getFlag(language),
                                      style: const TextStyle(fontSize: 17),
                                    ),

                                    const SizedBox(width: 7),

                                    Text(language),
                                  ],
                                ),
                              );
                            }).toList(),

                            onChanged: (value) {
                              if (value == null) {
                                return;
                              }

                              setState(() {
                                _selectedLanguage = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),

                  // =========================
                  // CENTER CONTENT
                  // =========================
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                          textAlign: TextAlign.center,

                          text: TextSpan(
                            style: GoogleFonts.quicksand(
                              fontSize: 37,
                              height: 1.15,
                              fontWeight: FontWeight.w600,
                              color: scheme.onSurface,
                            ),

                            children: [
                              const TextSpan(text: 'Where do you\n'),

                              TextSpan(
                                text: 'want to go?',
                                style: GoogleFonts.quicksand(
                                  fontSize: 37,
                                  fontWeight: FontWeight.w800,
                                  color: scheme.primary,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 18),

                        Text(
                          'Plan your journey around the event that matters to you.',
                          textAlign: TextAlign.center,

                          style: GoogleFonts.quicksand(
                            fontSize: 15,
                            height: 1.5,
                            fontWeight: FontWeight.w500,
                            color: scheme.onSurfaceVariant,
                          ),
                        ),

                        const SizedBox(height: 42),

                        // =========================
                        // PLAN MY TRIP
                        // =========================
                        SizedBox(
                          width: double.infinity,
                          height: 58,

                          child: ElevatedButton(
                            onPressed: () => context.go('/plan'),

                            style: ElevatedButton.styleFrom(
                              backgroundColor: scheme.primary,
                              foregroundColor: scheme.onPrimary,
                              elevation: 0,

                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                            ),

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.route_rounded, size: 22),

                                const SizedBox(width: 10),

                                Flexible(
                                  child: Text(
                                    'Plan my trip',
                                    style: GoogleFonts.quicksand(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 14),

                        // =========================
                        // SAVED TRIPS
                        // =========================
                        SizedBox(
                          width: double.infinity,
                          height: 58,

                          child: OutlinedButton(
                            onPressed: () => context.go('/saved'),

                            style: OutlinedButton.styleFrom(
                              foregroundColor: scheme.onSurface,

                              side: BorderSide(
                                color: scheme.primary,
                                width: 1.5,
                              ),

                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                            ),

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.bookmark_outline_rounded,
                                  color: scheme.primary,
                                  size: 22,
                                ),

                                const SizedBox(width: 10),

                                Flexible(
                                  child: Text(
                                    'Saved Trips',
                                    style: GoogleFonts.quicksand(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: scheme.onSurface,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // =========================
                  // FOOTER
                  // =========================
                  Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          showAboutDialog(
                            context: context,
                            applicationName: 'Go2Point',
                            children: const [
                              Text(
                                'Plan a journey around your favourite event.',
                              ),
                            ],
                          );
                        },

                        child: Text(
                          'About the app',
                          style: GoogleFonts.quicksand(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                      ),

                      Container(
                        width: 4,
                        height: 4,

                        decoration: BoxDecoration(
                          color: scheme.primary,
                          shape: BoxShape.circle,
                        ),
                      ),

                      TextButton(
                        onPressed: () {
                          showAppMessage(
                            context,
                            'Feedback submission will be available later.',
                          );
                        },

                        child: Text(
                          'Feedback',
                          style: GoogleFonts.quicksand(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _getFlag(String language) {
    switch (language) {
      case 'EN':
        return '🇬🇧';

      case 'RO':
        return '🇷🇴';

      case 'RU':
        return '🇷🇺';

      default:
        return '🌐';
    }
  }
}

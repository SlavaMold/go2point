import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const Go2PointApp());
}

class Go2PointApp extends StatelessWidget {
  const Go2PointApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Go2Point',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFB8A1FF),
        ),
        textTheme: GoogleFonts.quicksandTextTheme(),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedLanguage = 'EN';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // Header
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(width: 8),
            SvgPicture.asset(
              'assets/logo/Logo_Go2point.svg',
              height: 32,
              width: 32,
            ),

            Text(
              'Go2Point',
              style: GoogleFonts.quicksand(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF18151F),
              ),
            )
        ],
      ),

      actions: [
        Padding(
            padding: const EdgeInsets.only(right: 16),
            child: DropdownButton<String>(
              value: selectedLanguage,
              underline: const SizedBox(),
              icon: const Icon(Icons.keyboard_arrow_down),
              items: const [
                DropdownMenuItem(
                  value: 'EN',
                  child: Text('🇬🇧 EN'),
                ),
                DropdownMenuItem(
                  value: 'RO',
                  child: Text('🇷🇴 RO'),
                ),
                DropdownMenuItem(
                  value: 'RU',
                  child: Text('🇷🇺 RU'),
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedLanguage = value;
                  });
                }
              },
            ),
          ),
        ],
      ),

      // Main content
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            children: [
              const Spacer(),

              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: GoogleFonts.quicksand(
                    fontSize: 38,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF18151F),
                    height: 1.15,
                  ),
                  children: [
                    const TextSpan(
                      text: 'Where are you\n',
                    ),
                    TextSpan(
                      text: 'want to go?',
                      style: GoogleFonts.quicksand(
                        fontSize: 38,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF9B7EFF),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 45),

              // Plan my trip
              SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF9B7EFF),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: Text(
                    'Plan my trip',
                    style: GoogleFonts.quicksand(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Saved Trips
              SizedBox(
                width: double.infinity,
                height: 58,
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF18151F),
                    side: const BorderSide(
                      color: Color(0xFF9B7EFF),
                      width: 1.5,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: Text(
                    'Saved Trips',
                    style: GoogleFonts.quicksand(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),

              const Spacer(),

              // Footer
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'About the app',
                        style: TextStyle(
                          color: Color(0xFF18151F),
                          fontSize: 15,
                        ),
                      ),
                    ),
                    const Text(
                      '•',
                      style: TextStyle(
                        color: Color(0xFFB8A1FF),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Feedback',
                        style: TextStyle(
                          color: Color(0xFF18151F),
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
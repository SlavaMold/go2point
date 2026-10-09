import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'pages/register_page.dart';
import 'pages/login_page.dart';
import 'pages/trip_planner_page.dart';
import 'theme/app_colors.dart';
import 'pages/route_details_page.dart';
import 'pages/alternative_routes_page.dart';
import 'pages/saved_routes_page.dart';
import 'pages/profile_page.dart';
import 'pages/edit_route_page.dart';

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
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.white,

        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.purple,
        ),

        textTheme: GoogleFonts.quicksandTextTheme(),
      ),

      home: const EditRoutePage(),
    );
  }
}
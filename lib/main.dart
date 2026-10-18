import 'package:flutter/material.dart';

import 'pages/trip_planner_page.dart';
import 'theme/app_theme.dart';

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

      theme: AppTheme.light(),

      home: const TripPlannerPage(),
    );
  }
}

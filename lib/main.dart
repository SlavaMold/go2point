import 'package:flutter/material.dart';

import 'router.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const Go2PointApp());
}

class Go2PointApp extends StatelessWidget {
  const Go2PointApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,

      title: 'Go2Point',

      theme: AppTheme.light(),

      routerConfig: router,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:go2point/models/trip_route.dart';
import 'package:go2point/pages/edit_route_page.dart';
import 'package:go2point/pages/alternative_routes_page.dart';
import 'package:go2point/pages/home_page.dart';
import 'package:go2point/pages/login_page.dart';
import 'package:go2point/pages/route_details_page.dart';
import 'package:go2point/pages/saved_routes_page.dart';
import 'package:go2point/router.dart';
import 'package:go2point/theme/app_theme.dart';
import 'package:go2point/widgets/app_text_field.dart';

void main() {
  setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false);

  testWidgets(
    'Welcome page scrolls on a small phone and links to both sections',
    (tester) async {
      final router = await _openApp(
        tester,
        '/home',
        size: const Size(320, 480),
      );
      expect(find.byType(HomePage), findsOneWidget);
      expect(find.byType(NavigationDestination), findsNWidgets(4));
      expect(tester.takeException(), isNull);
      tester.view.physicalSize = const Size(430, 932);
      await tester.pumpAndSettle();
      await _tap(tester, find.text('Plan my trip'));
      expect(router.routeInformationProvider.value.uri.path, '/plan');
      router.go('/home');
      await tester.pumpAndSettle();
      await _tap(tester, find.text('Saved Trips'));
      expect(router.routeInformationProvider.value.uri.path, '/saved');
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'Planner rejects empty fields, zero budget and inconsistent dates',
    (tester) async {
      final router = await _openApp(tester, '/plan');
      await _tap(tester, find.text('Build my route'));
      expect(find.text('This field is required'), findsNWidgets(4));
      expect(find.text('Select a date'), findsNWidgets(3));
      expect(find.text('Enter an amount'), findsOneWidget);
      expect(router.routeInformationProvider.value.uri.path, '/plan');

      final arrival = DateUtils.dateOnly(DateTime.now())
          .add(const Duration(days: 10));
      _set(tester, 'From', 'Chisinau');
      _set(tester, 'Destination', 'Budapest');
      _set(tester, 'Event', 'Concert');
      _set(tester, 'Event location', 'Main square');
      _set(tester, 'Arrival', formatTripDate(arrival));
      _set(
        tester,
        'Departure',
        formatTripDate(arrival.subtract(const Duration(days: 1))),
      );
      _set(
        tester,
        'Event date',
        formatTripDate(arrival.add(const Duration(days: 5))),
      );
      _set(tester, 'Budget', '0');
      await _tap(tester, find.text('Build my route'));
      expect(find.text('Budget must be greater than 0'), findsOneWidget);
      expect(find.text('Departure cannot precede arrival'), findsOneWidget);
      expect(find.text('Event must be during your stay'), findsOneWidget);
      expect(router.routeInformationProvider.value.uri.path, '/plan');

      _set(
        tester,
        'Departure',
        formatTripDate(arrival.add(const Duration(days: 6))),
      );
      _set(tester, 'Budget', '40,50');
      await _tap(tester, find.text('Build my route'));
      expect(find.byType(AlternativeRoutesPage), findsOneWidget);
      expect(
        find.text('Trip details are valid. Showing demo routes.'),
        findsOneWidget,
      );
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('Budget minimum stays zero at both percentage limits', (
    tester,
  ) async {
    await _openApp(tester, '/plan');
    _set(tester, 'Budget', '200');
    await tester.pumpAndSettle();
    expect(find.text('€0 — €230.00'), findsOneWidget);
    for (var i = 0; i < 50; i++) {
      await _tap(tester, find.byIcon(Icons.add));
    }
    expect(find.text('50%'), findsOneWidget);
    expect(find.text('€0 — €300'), findsOneWidget);
    for (var i = 0; i < 51; i++) {
      await _tap(tester, find.byIcon(Icons.remove));
    }
    expect(find.text('0%'), findsOneWidget);
    expect(find.text('€0 — €200'), findsOneWidget);
    _set(tester, 'Budget', '40,50');
    await tester.pumpAndSettle();
    expect(find.text('€0 — €40.50'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'Editor rejects bad data; reset needs confirmation; valid submit returns',
    (tester) async {
      await _openApp(tester, '/saved/2/edit');
      final original = _widget(tester, 'From').controller!.text;
      _set(tester, 'From', '');
      _set(tester, 'Price', '');
      _set(tester, 'Event date', '01/01/2030');
      await _tap(tester, find.text('Save changes'));
      expect(find.byType(EditRoutePage), findsOneWidget);
      expect(find.text('This field is required'), findsOneWidget);
      expect(find.text('Enter an amount'), findsOneWidget);
      expect(find.text('Event must be during your stay'), findsOneWidget);

      await _tap(tester, find.text('Reset changes'));
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();
      expect(_widget(tester, 'From').controller!.text, '');
      await _tap(tester, find.text('Reset changes'));
      await tester.tap(find.widgetWithText(FilledButton, 'Reset'));
      await tester.pumpAndSettle();
      expect(_widget(tester, 'From').controller!.text, original);
      expect(find.text('Event must be during your stay'), findsNothing);
      await tester.pump(const Duration(seconds: 4));
      await tester.pumpAndSettle();
      _set(tester, 'Price', '0');
      await _tap(tester, find.text('Save changes'));
      expect(find.byType(EditRoutePage), findsNothing);
      expect(find.byType(RouteDetailsPage), findsOneWidget);
      expect(
        find.text('Route changes are valid. Demo data is unchanged.'),
        findsOneWidget,
      );
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'Logout handles cancel, dismissal and confirm; deletion confirms mock action',
    (tester) async {
      final router = await _openApp(tester, '/profile');
      await tester.tap(find.byTooltip('Sign out'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();
      expect(router.routeInformationProvider.value.uri.path, '/profile');
      await tester.tap(find.byTooltip('Sign out'));
      await tester.pumpAndSettle();
      await tester.tapAt(const Offset(5, 5));
      await tester.pumpAndSettle();
      expect(router.routeInformationProvider.value.uri.path, '/profile');
      await tester.tap(find.byTooltip('Sign out'));
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(FilledButton, 'Sign out'));
      await tester.pumpAndSettle();
      expect(find.byType(LoginPage), findsOneWidget);
      expect(router.canPop(), isFalse);

      router.go('/saved');
      await tester.pumpAndSettle();
      await _tap(tester, find.text('Remove').hitTestable());
      await tester.tap(find.widgetWithText(FilledButton, 'Delete'));
      await tester.pumpAndSettle();
      expect(find.byType(SavedRoutesPage), findsOneWidget);
      expect(
        find.text('Deletion confirmed. Demo data is unchanged.'),
        findsOneWidget,
      );
      expect(tester.takeException(), isNull);
    },
  );
}

AppTextField _widget(WidgetTester tester, String label) => tester
    .widgetList<AppTextField>(find.byType(AppTextField))
    .firstWhere((f) => f.label == label);

void _set(WidgetTester tester, String label, String value) =>
    _widget(tester, label).controller!.text = value;

Future<void> _tap(WidgetTester tester, Finder finder) async {
  tester.testTextInput.hide();
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

Future<GoRouter> _openApp(
  WidgetTester tester,
  String location, {
  Size size = const Size(430, 932),
}) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  final router = createAppRouter(initialLocation: location);
  addTearDown(router.dispose);
  await tester.pumpWidget(
    MaterialApp.router(theme: AppTheme.light(), routerConfig: router),
  );
  await tester.pumpAndSettle();
  return router;
}

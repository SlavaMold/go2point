import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:go2point/pages/alternative_routes_page.dart';
import 'package:go2point/pages/edit_route_page.dart';
import 'package:go2point/pages/login_page.dart';
import 'package:go2point/pages/home_page.dart';
import 'package:go2point/models/trip_route.dart';
import 'package:go2point/pages/register_page.dart';
import 'package:go2point/pages/route_details_page.dart';
import 'package:go2point/pages/saved_routes_page.dart';
import 'package:go2point/pages/trip_planner_page.dart';
import 'package:go2point/router.dart';
import 'package:go2point/theme/app_theme.dart';
import 'package:go2point/widgets/alternative_route_card.dart';
import 'package:go2point/widgets/app_text_field.dart';
import 'package:go2point/widgets/saved_route_card.dart';

void main() {
  setUpAll(() {
    // Navigation tests use the bundled font assets, never the network.
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  testWidgets(
    'Login and registration have no tabs; entering removes auth history',
    (tester) async {
      final appRouter = await _openApp(tester);
      expect(find.byType(LoginPage), findsOneWidget);
      expect(find.byType(NavigationBar), findsNothing);

      await tester.tap(find.text('Sign Up'));
      await tester.pumpAndSettle();
      expect(find.byType(RegisterPage), findsOneWidget);
      expect(find.byType(NavigationBar), findsNothing);

      await tester.tap(find.text('Sign In'));
      await tester.pumpAndSettle();
      expect(find.byType(LoginPage), findsOneWidget);

      await tester.tap(find.text('Sign In'));
      await tester.pumpAndSettle();
      expect(find.byType(HomePage), findsOneWidget);
      expect(find.byType(NavigationBar), findsOneWidget);
      expect(appRouter.canPop(), isFalse);
      expect(find.byType(LoginPage, skipOffstage: false), findsNothing);

      await _switchTab(tester, 3);
      await tester.tap(find.byTooltip('Sign out'));
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(FilledButton, 'Sign out'));
      await tester.pumpAndSettle();
      expect(find.byType(LoginPage), findsOneWidget);
      expect(find.byType(NavigationBar), findsNothing);
      expect(appRouter.canPop(), isFalse);
    },
  );

  testWidgets('Tabs retain form input, list position and the open editor', (
    tester,
  ) async {
    await _openApp(tester, location: '/plan');
    final budget = find.descendant(
      of: find.byWidgetPredicate(
        (widget) => widget is AppTextField && widget.label == 'Budget',
      ),
      matching: find.byType(TextField),
    );
    await tester.ensureVisible(budget);
    await tester.enterText(budget, '800');
    tester.testTextInput.hide();
    await tester.pumpAndSettle();

    await _switchTab(tester, 2);
    final listState = tester.state(find.byType(SavedRoutesPage));
    final controller = tester
        .widget<PageView>(find.byType(PageView))
        .controller!;
    await tester.drag(find.byType(PageView), const Offset(0, -600));
    await tester.pumpAndSettle();
    expect(controller.page, closeTo(1, 0.01));

    await _switchTab(tester, 1);
    expect(tester.widget<TextField>(budget).controller!.text, '800');
    await _switchTab(tester, 2);
    expect(tester.state(find.byType(SavedRoutesPage)), same(listState));
    expect(controller.page, closeTo(1, 0.01));

    await tester.tap(find.byType(SavedRouteCard).hitTestable());
    await tester.pumpAndSettle();
    expect(
      tester.widget<RouteDetailsPage>(find.byType(RouteDetailsPage)).id,
      4,
    );
    expect(find.byType(NavigationBar), findsOneWidget);

    await _tapVisible(tester, find.text('Edit route'));
    final editorState = tester.state(find.byType(EditRoutePage));
    expect(tester.widget<EditRoutePage>(find.byType(EditRoutePage)).id, 4);
    await tester.enterText(find.byType(TextField).first, 'Balti');
    tester.testTextInput.hide();
    await tester.pumpAndSettle();

    await _switchTab(tester, 3);
    await _switchTab(tester, 2);
    expect(tester.state(find.byType(EditRoutePage)), same(editorState));
    expect(
      tester.widget<TextField>(find.byType(TextField).first).controller!.text,
      'Balti',
    );

    await _tapVisible(tester, find.text('Save changes'));
    expect(find.byType(EditRoutePage), findsNothing);
    expect(
      tester.widget<RouteDetailsPage>(find.byType(RouteDetailsPage)).id,
      4,
    );
    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    expect(find.byType(SavedRoutesPage), findsOneWidget);
    expect(controller.page, closeTo(1, 0.01));
    expect(tester.takeException(), isNull);
  });

  testWidgets('Planner opens alternatives, details and editor within its tab', (
    tester,
  ) async {
    await _openApp(tester, location: '/plan');
    _fillPlanner(tester);
    await _tapVisible(tester, find.text('Build my route'));
    expect(find.byType(AlternativeRoutesPage), findsOneWidget);
    expect(find.byType(NavigationBar), findsOneWidget);

    final recommended = find.byWidgetPredicate(
      (widget) => widget is AlternativeRouteCard && widget.isRecommended,
    );
    await _tapVisible(
      tester,
      find.descendant(of: recommended, matching: find.text('View route')),
    );
    expect(
      tester.widget<RouteDetailsPage>(find.byType(RouteDetailsPage)).id,
      2,
    );
    await _tapVisible(tester, find.text('Edit route'));
    expect(tester.widget<EditRoutePage>(find.byType(EditRoutePage)).id, 2);
    expect(find.byType(NavigationBar), findsOneWidget);

    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    await _tapVisible(tester, find.text('See alternatives'));
    expect(find.byType(AlternativeRoutesPage), findsOneWidget);
    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    expect(find.byType(TripPlannerPage), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}

Future<GoRouter> _openApp(
  WidgetTester tester, {
  String location = '/login',
}) async {
  tester.view.physicalSize = const Size(430, 932);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  final appRouter = createAppRouter(initialLocation: location);
  addTearDown(appRouter.dispose);
  await tester.pumpWidget(
    MaterialApp.router(theme: AppTheme.light(), routerConfig: appRouter),
  );
  await tester.pumpAndSettle();
  return appRouter;
}

Future<void> _switchTab(WidgetTester tester, int index) async {
  await tester.tap(find.byType(NavigationDestination).at(index));
  await tester.pumpAndSettle();
}

Future<void> _tapVisible(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

void _fillPlanner(WidgetTester tester) {
  final start = DateUtils.dateOnly(DateTime.now())
      .add(const Duration(days: 10));
  final values = {
    'From': 'Chisinau',
    'Destination': 'Budapest',
    'Event': 'Concert',
    'Event location': 'Main square',
    'Arrival': formatTripDate(start),
    'Departure': formatTripDate(start.add(const Duration(days: 3))),
    'Event date': formatTripDate(start.add(const Duration(days: 1))),
    'Budget': '600',
  };
  for (final field in tester.widgetList<AppTextField>(
    find.byType(AppTextField),
  )) {
    field.controller!.text = values[field.label]!;
  }
}

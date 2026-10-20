import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:go2point/pages/alternative_routes_page.dart';
import 'package:go2point/pages/edit_route_page.dart';
import 'package:go2point/pages/login_page.dart';
import 'package:go2point/pages/home_page.dart';
import 'package:go2point/pages/not_found_page.dart';
import 'package:go2point/pages/profile_page.dart';
import 'package:go2point/pages/register_page.dart';
import 'package:go2point/pages/route_details_page.dart';
import 'package:go2point/pages/saved_routes_page.dart';
import 'package:go2point/pages/trip_planner_page.dart';
import 'package:go2point/router.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('The application starts at login', () {
    final appRouter = createAppRouter();
    addTearDown(appRouter.dispose);
    expect(appRouter.routeInformationProvider.value.uri.path, '/login');
  });

  testWidgets('Every screen has an address and receives its path ID', (
    tester,
  ) async {
    final appRouter = createAppRouter();
    addTearDown(appRouter.dispose);
    final destinations = <String, Matcher>{
      '/login': isA<LoginPage>(),
      '/register': isA<RegisterPage>(),
      '/home': isA<HomePage>(),
      '/plan': isA<TripPlannerPage>(),
      '/plan/alternatives': isA<AlternativeRoutesPage>(),
      '/plan/alternatives/1': isA<RouteDetailsPage>().having(
        (p) => p.id,
        'id',
        1,
      ),
      '/plan/alternatives/2/edit': isA<EditRoutePage>().having(
        (p) => p.id,
        'id',
        2,
      ),
      '/saved': isA<SavedRoutesPage>(),
      '/saved/4': isA<RouteDetailsPage>().having((p) => p.id, 'id', 4),
      '/saved/4/edit': isA<EditRoutePage>().having((p) => p.id, 'id', 4),
      '/profile': isA<ProfilePage>(),
      '/saved/not-a-number': isA<NotFoundPage>(),
      '/saved/not-a-number/edit': isA<NotFoundPage>(),
    };

    await tester.pumpWidget(
      Builder(
        builder: (context) {
          for (final destination in destinations.entries) {
            final matches = appRouter.configuration.findMatch(
              Uri.parse(destination.key),
            );
            expect(matches.isError, isFalse, reason: destination.key);
            // A shell wraps its leaf matches; descend into its active branch.
            RouteMatchBase currentMatch = matches.matches.last;
            while (currentMatch is ShellRouteMatch) {
              currentMatch = currentMatch.matches.last;
            }
            final match = currentMatch as RouteMatch;
            final state = match.buildState(
              appRouter.configuration,
              matches,
              metadata: const {},
            );
            final page = match.route.builder!(context, state);
            expect(page, destination.value, reason: destination.key);
          }
          return const SizedBox();
        },
      ),
    );
  });

  testWidgets('An unknown address resolves to the error page', (tester) async {
    final appRouter = createAppRouter(initialLocation: '/does-not-exist');
    addTearDown(appRouter.dispose);
    final matches = appRouter.configuration.findMatch(
      Uri.parse('/does-not-exist'),
    );
    expect(matches.isError, isTrue);
    await tester.pumpWidget(MaterialApp.router(routerConfig: appRouter));
    appRouter.go('/does-not-exist');
    await tester.pumpAndSettle();
    expect(find.byType(NotFoundPage), findsOneWidget);
  });
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'pages/alternative_routes_page.dart';
import 'pages/edit_route_page.dart';
import 'pages/login_page.dart';
import 'pages/home_page.dart';
import 'pages/not_found_page.dart';
import 'pages/profile_page.dart';
import 'pages/register_page.dart';
import 'pages/route_details_page.dart';
import 'pages/saved_routes_page.dart';
import 'pages/trip_planner_page.dart';
import 'widgets/app_shell.dart';

// Created once. Restart the application after changing the route map.
final router = createAppRouter();

GoRouter createAppRouter({String initialLocation = '/login'}) => GoRouter(
  initialLocation: initialLocation,
  routes: [
    GoRoute(path: '/', redirect: (context, state) => '/login'),
    GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterPage(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          AppShell(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const HomePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/plan',
              builder: (context, state) => const TripPlannerPage(),
              routes: [
                GoRoute(
                  path: 'alternatives',
                  builder: (context, state) => const AlternativeRoutesPage(),
                  routes: _tripRoutes(),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/saved',
              builder: (context, state) => const SavedRoutesPage(),
              routes: _tripRoutes(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfilePage(),
            ),
          ],
        ),
      ],
    ),
  ],
  errorBuilder: (context, state) => const NotFoundPage(),
);

// Both lists reuse the same detail and editor pages. Only the ID travels.
List<RouteBase> _tripRoutes() => [
  GoRoute(
    path: ':id',
    builder: (context, state) => _tripPage(state),
    routes: [
      GoRoute(
        path: 'edit',
        builder: (context, state) => _tripPage(state, edit: true),
      ),
    ],
  ),
];

Widget _tripPage(GoRouterState state, {bool edit = false}) {
  final id = int.tryParse(state.pathParameters['id'] ?? '');
  if (id == null) {
    return const NotFoundPage(message: 'The trip ID must be a number.');
  }
  return edit
      ? EditRoutePage(key: ValueKey('edit-$id'), id: id)
      : RouteDetailsPage(key: ValueKey('details-$id'), id: id);
}

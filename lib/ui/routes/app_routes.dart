import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../auth/ui/pages/landing_page.dart';
import '../widgets/main_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

class AppRoutes {
  static final GoRouter _router =
      GoRouter(navigatorKey: _rootNavigatorKey, routes: [
    GoRoute(
      path: '/',
      redirect: (_, __) => '/main',
    ),
    GoRoute(
      path: '/auth',
      builder: (context, state) => const LandingPage(),
    ),
    GoRoute(
      path: '/main',
      builder: (context, state) => const MainPage(),
    ),
    ShellRoute(),
  ]);

  static GoRouter get router => _router;
}

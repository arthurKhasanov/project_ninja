import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../auth/ui/pages/auth_page.dart';
import '../../auth/ui/pages/landing_page.dart';
import '../widgets/main_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

enum AppPages {
  root('root', '/'),
  todos('todos', '/todos'),
  auth('auth', '/auth');
  

  const AppPages(this.name, this.path);

  final String name;
  final String path;
}

class AppRoutes {
  static final GoRouter _router = GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppPages.root.path,
    routes: [
      GoRoute(
        name: AppPages.root.name,
        path: AppPages.root.path,
        builder: (context, state) => const InitialPage(),
      ),
      GoRoute(
        name: AppPages.auth.name,
        path: AppPages.auth.path,
        builder: (context, state) => const LandingPage(),
      ),
      GoRoute(
        name: AppPages.todos.name,
        path: AppPages.todos.path,
        builder: (context, state) => const MainPage(),
      ),
    ],
  );

  static GoRouter get router => _router;
}

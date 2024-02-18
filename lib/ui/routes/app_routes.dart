import 'package:flutter/material.dart';
import 'package:flutter_b_ui_layout/auth/domain/bloc/auth_bloc/auth_bloc.dart';
import 'package:flutter_b_ui_layout/auth/domain/bloc/auth_bloc/auth_state.dart';
import 'package:flutter_b_ui_layout/ui/widgets/add_task_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../auth/ui/pages/landing_page.dart';
import '../widgets/main_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

enum AppPages {
  root('root', '/'),
  tasks('tasks', '/tasks'),
  addTask('addTask', '/addTask'),
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
    redirect: (BuildContext context, GoRouterState state) {
      final AuthState authState = context.read<AuthBloc>().state;

      if (authState is AuthorizedState) {
        
        if (state.location != AppPages.root.path) {
          return state.fullpath;
        } else {
          return AppPages.tasks.path;
        }
      } else {
        return AppPages.auth.path;
      }
    },
    routes: [
      GoRoute(
        name: AppPages.auth.name,
        path: AppPages.auth.path,
        builder: (context, state) => const LandingPage(),
      ),
      GoRoute(
        name: AppPages.tasks.name,
        path: AppPages.tasks.path,
        builder: (context, state) => const MainPage(),
      ),
      GoRoute(
        name: AppPages.addTask.name,
        path: AppPages.addTask.path,
        builder: (context, state) => const AppTaskPage(),
      ),
    ],
  );

  static GoRouter get router => _router;
}

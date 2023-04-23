import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_b_ui_layout/core/dependency_injection/service_locator.dart';
import 'package:flutter_b_ui_layout/ui/routes/app_routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../domain/bloc/auth_bloc/auth_bloc.dart';
import '../../domain/bloc/auth_bloc/auth_state.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) => locator(),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          SchedulerBinding.instance.addPostFrameCallback(
            (timeStamp) {
              if (state is AuthorizedState) {
                context.goNamed(AppPages.todos.name);
              } else {
                context.goNamed(AppPages.auth.name);
              }
            },
          );
          return const SizedBox();
        },
      ),
    );
  }
}

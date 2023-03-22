import 'package:flutter/material.dart';
import 'package:flutter_b_ui_layout/auth/ui/pages/landing_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../ui/widgets/main_screen.dart';
import '../../data/firebase_auth_repository.dart';
import '../../domain/bloc/auth_bloc/auth_bloc.dart';
import '../../domain/bloc/auth_bloc/auth_state.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      //TODO: add locator()
      create: (context) => AuthBloc(authRepository: FirebaseAuthRepository()),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthorizedState) {
            return const MainPage();
          } else {
            return const LandingPage();
          }
        },
      ),
    );
  }
}

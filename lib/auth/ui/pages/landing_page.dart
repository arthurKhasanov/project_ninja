import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_b_ui_layout/auth/domain/bloc/auth_bloc/auth_bloc.dart';
import 'package:flutter_b_ui_layout/auth/domain/bloc/auth_bloc/auth_state.dart';
import 'package:flutter_b_ui_layout/auth/domain/bloc/landing_animation_bloc/landing_animation_bloc.dart';
import 'package:flutter_b_ui_layout/auth/domain/bloc/landing_animation_bloc/landing_animation_event.dart';
import 'package:flutter_b_ui_layout/core/dependency_injection/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';
import '../widgets/bouncing_button.dart';
import '../widgets/sign_in_dialog/sign_in_dialog.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  Future<Object?> _startAuth(BuildContext context) {
    final AuthBloc authBloc = context.read<AuthBloc>();
    final LandingAnimationBloc landingAnimationBloc =
        context.read<LandingAnimationBloc>()..add(AuthStarted());

    return showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: 'Sign In',
        barrierColor: Colors.black87,
        transitionBuilder: (context, animation, secondaryAnimation, child) {
          final tween =
              Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero);
          return SlideTransition(
            position: tween.animate(
              CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn),
            ),
            child: child,
          );
        },
        pageBuilder: (context, _, __) => MultiBlocProvider(
              providers: [
                BlocProvider<LandingAnimationBloc>.value(
                  value: landingAnimationBloc,
                ),
                BlocProvider<AuthBloc>.value(
                  value: authBloc,
                ),
              ],
              child: const SignInDialog(),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LandingAnimationBloc>(
          create: (context) => LandingAnimationBloc(),
        ),
        BlocProvider.value(
          value: locator<AuthBloc>(),
        )
      ],
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {},
        child: BlocBuilder<LandingAnimationBloc, bool>(
            builder: (context, isDialogShown) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Stack(children: [
              const RiveAnimation.asset(
                'assets/rive_animations/auth/landing_background.riv',
                fit: BoxFit.cover,
              ),
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: const SizedBox(),
                ),
              ),
              AnimatedPositioned(
                top: isDialogShown ? -50 : 0,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                duration: const Duration(milliseconds: 200),
                child: SafeArea(
                    child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    children: [
                      const Spacer(
                        flex: 1,
                      ),
                      const Text(
                        'Project Ninja',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.white,
                          fontSize: 65,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      const Text(
                        'Create projects. Manage projects. Create healthy habits. Take control of your every day.',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(
                        flex: 3,
                      ),
                      BouncingButton(
                        onTap: () {
                          _startAuth(context);
                        },
                        child: const Text(
                          'Start now',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 24,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                )),
              )
            ]),
          );
        }),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_b_ui_layout/auth/domain/bloc/landing_animation_bloc/landing_animation_bloc.dart';
import 'package:flutter_b_ui_layout/auth/ui/widgets/sign_up_dialog/sign_up_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../ui/widgets/bouncing_widget.dart';
import '../../../domain/bloc/auth_bloc/auth_bloc.dart';
import '../../../domain/bloc/auth_bloc/auth_event.dart';

class SignUpInfoBlock extends StatelessWidget {
  const SignUpInfoBlock({super.key});

  Future<Object?> _signUp(BuildContext context) {
    final landingAnimationBloc = context.read<LandingAnimationBloc>();

    return showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: 'Sign In',
        barrierColor: Colors.black87,
        transitionBuilder: (context, animation, secondaryAnimation, child) {
          final tween = Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero);
          return SlideTransition(
            position: tween.animate(
              CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn),
            ),
            child: child,
          );
        },
        pageBuilder: (context, _, __) => BlocProvider<LandingAnimationBloc>.value(
              value: landingAnimationBloc,
              child: const SignUpDialog(),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Don\'t have an account?',
          style: TextStyle(fontSize: 12),
        ),
        const Text(
          'Sign up with Email or continue with Google account',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12),
        ),
        const SizedBox(
          height: 12,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BouncingWidget(
              onTap: () {
                Navigator.pop(context);
                _signUp(context);
                debugPrint('sign up');
              },
              child: Image.asset(
                'assets/icons/auth/mail.png',
                width: 35,
                height: 35,
              ),
            ),
            BouncingWidget(
              onTap: () {
                context.read<AuthBloc>().add(GoogleSignUpEvent());
                Navigator.pop(context);
              },
              child: Image.asset(
                'assets/icons/auth/google.png',
                width: 35,
                height: 35,
              ),
            ),
          ],
        )
      ],
    );
  }
}

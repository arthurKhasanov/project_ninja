import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/bloc/landing_animation_bloc/landing_animation_bloc.dart';
import '../../domain/bloc/landing_animation_bloc/landing_animation_event.dart';

class SignUpDialog extends StatelessWidget {
  const SignUpDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<LandingAnimationBloc>().add(AuthCanceled());
        return true;
      },
      child: AlertDialog(
        scrollable: true,
        clipBehavior: Clip.hardEdge,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
        backgroundColor: Colors.white.withOpacity(0.95),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Sign Up',
              style: TextStyle(
                  color: Colors.black87,
                  fontFamily: 'Montserrat',
                  fontSize: 35),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Text(
                'To get started, please sign in with your account information below. If you\'re new here, simply create a new account to start organizing your tasks and taking control of your day.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black87, fontFamily: 'Inter', fontSize: 12),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: const [
                Expanded(child: Divider()),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'OR',
                    style:
                        TextStyle(fontFamily: 'Inter', color: Colors.black87),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

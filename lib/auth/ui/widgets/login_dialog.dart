import 'package:flutter/material.dart';
import 'package:flutter_b_ui_layout/auth/ui/widgets/sing_in_form.dart';

import '../../../widgets/bouncing_widget.dart';

class LogInDialog extends StatelessWidget {
  const LogInDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      clipBehavior: Clip.hardEdge,
      contentPadding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      backgroundColor: Colors.white.withOpacity(0.95),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Sign In',
            style: TextStyle(
                color: Colors.black87, fontFamily: 'Montserrat', fontSize: 35),
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
          SignInForm(
            signIn: () {
              debugPrint('sign in');
            },
            resetPassword: () {
              debugPrint('reset password');
            },
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: const [
              Expanded(child: Divider()),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'OR',
                  style: TextStyle(fontFamily: 'Inter', color: Colors.black87),
                ),
              ),
              Expanded(child: Divider()),
            ],
          ),
          const Text(
            'Don\'t have an account?',
            style: TextStyle(fontFamily: 'Inter', fontSize: 12),
          ),
          const Text(
            'Sign up with Email or continue with Google account',
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: 'Inter', fontSize: 12),
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BouncingWidget(
                onTap: () {
                  //TODO: add log in with apple logic
                  debugPrint('Apple');
                },
                child: Image.asset(
                  'assets/icons/auth/mail.png',
                  width: 35,
                  height: 35,
                ),
              ),
              BouncingWidget(
                onTap: () {
                  //TODO: add log in with google logic

                  debugPrint('Google');
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
      ),
    );
  }
}

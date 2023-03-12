import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_b_ui_layout/auth/ui/widgets/sing_in_form.dart';

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
          const SignInForm(),
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
          Center(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Sign up with email ',
                    style: const TextStyle(color: Colors.indigo, fontSize: 16),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        print('Sign Up with Email');
                      },
                  ),
                  const TextSpan(
                    text: 'or ',
                    style: TextStyle(color: Colors.black87, fontSize: 16),
                  ),
                  TextSpan(
                    text: 'Google account',
                    style: const TextStyle(color: Colors.red, fontSize: 16),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        print('Sign Up with Google Account');
                      },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


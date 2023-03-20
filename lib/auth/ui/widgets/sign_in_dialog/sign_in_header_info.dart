import 'package:flutter/material.dart';

class SignInHeaderInfo extends StatelessWidget {
  const SignInHeaderInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text(
          'Sign In',
          style: TextStyle(
              color: Colors.black87, fontFamily: 'Montserrat', fontSize: 35),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Text(
            'To get started, please sign in with your account information below. If you\'re new here, simply create a new account to start organizing your tasks and taking control of your day.',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black87, fontFamily: 'Inter', fontSize: 12),
          ),
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';

class ForgotPasswordHeaderInfo extends StatelessWidget {
  const ForgotPasswordHeaderInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          'Reset password',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black87, fontFamily: 'Montserrat', fontSize: 35),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Text(
            'Please, enter your email address. You will recieve a link to create a new password',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black87, fontSize: 12),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class SignUpHeaderInfo extends StatelessWidget {
  const SignUpHeaderInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          'Sign Up',
          style: TextStyle(color: Colors.black87, fontFamily: 'Montserrat', fontSize: 35),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Text(
            'It\'s quick and easy',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black87, fontSize: 12),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
                hintText: 'Email',
                hintStyle: TextStyle(
                  fontFamily: 'Inter',
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                prefixIcon: Icon(FontAwesomeIcons.envelope),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(14),
                  ),
                )),
          ),
          const SizedBox(
            height: 16,
          ),
          TextFormField(
            obscureText: true,
            decoration: const InputDecoration(
                hintText: 'Password',
                hintStyle: TextStyle(
                  fontFamily: 'Inter',
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                prefixIcon: Icon(FontAwesomeIcons.lock),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(14),
                  ),
                )),
          ),
          const SizedBox(
            height: 16,
          ),
          ElevatedButton.icon(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 48),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                  bottomLeft: Radius.circular(4),
                  bottomRight: Radius.circular(4),
                ),
              ),
            ),
            icon: const Icon(FontAwesomeIcons.arrowRight),
            label: const Text(
              'Sign In',
              style: TextStyle(fontFamily: 'Montserrat',fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../widgets/animated_button.dart';
import '../widgets/sing_in_form.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
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
        SafeArea(
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
                  showGeneralDialog(
                    context: context,
                    barrierDismissible: true,
                    barrierLabel: 'Sign In',
                    pageBuilder: (context, _, __) {
                      return Center(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 24),
                          height: MediaQuery.of(context).size.height * 0.66,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.95),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Scaffold(
                            extendBody: true,
                            backgroundColor: Colors.transparent,
                            resizeToAvoidBottomInset: false,
                            body: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  'Sign In',
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
                                        color: Colors.black87,
                                        fontFamily: 'Inter',
                                        fontSize: 12),
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
                                        style: TextStyle(
                                            fontFamily: 'Inter',
                                            color: Colors.black87),
                                      ),
                                    ),
                                    Expanded(child: Divider()),
                                  ],
                                ),
                                Expanded(
                                  child: Center(
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Sign up with email ',
                                            style: const TextStyle(
                                                color: Colors.indigo,
                                                fontSize: 16),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                print('Sign Up with Email');
                                              },
                                          ),
                                          const TextSpan(
                                            text: 'or ',
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 16),
                                          ),
                                          TextSpan(
                                            text: 'Google account',
                                            style: const TextStyle(
                                                color: Colors.red,
                                                fontSize: 16),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                print(
                                                    'Sign Up with Google Account');
                                              },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
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
        ))
      ]),
    );
  }
}

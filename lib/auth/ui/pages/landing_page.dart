import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../widgets/animated_button.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              const Spacer(),
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
              const Spacer(flex: 3,),
              AnimatedButton(
                onTap: () {
                  debugPrint('tap');
                },
              ),
            ],
          ),
        ))
      ]),
    );
  }
}

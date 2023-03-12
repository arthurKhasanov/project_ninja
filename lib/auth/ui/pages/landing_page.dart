import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import '../widgets/animated_button.dart';
import '../widgets/login_dialog.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  bool isDialogShown = false;

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
        AnimatedPositioned(
          top: isDialogShown ? -50 : 0,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          duration: const Duration(milliseconds: 200),
          child: SafeArea(
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
                    setState(() {
                      isDialogShown = true;
                    });
                    showGeneralDialog(
                      context: context,
                      barrierDismissible: true,
                      barrierLabel: 'Sign In',
                      barrierColor: Colors.black87,
                      transitionBuilder:
                          (context, animation, secondaryAnimation, child) {
                        final tween = Tween<Offset>(
                            begin: const Offset(0, -1), end: Offset.zero);
                        return SlideTransition(
                          position: tween.animate(
                            CurvedAnimation(
                                parent: animation, curve: Curves.fastOutSlowIn),
                          ),
                          child: child,
                        );
                      },
                      pageBuilder: (context, _, __) {
                        return const LogInDialog();
                      },
                    ).then((value) => setState(() {
                          isDialogShown = false;
                        }));
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
          )),
        )
      ]),
    );
  }
}

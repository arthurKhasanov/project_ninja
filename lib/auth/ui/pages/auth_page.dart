import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_b_ui_layout/auth/ui/pages/landing_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/main_screen.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) return const MainPage();
          return const LandingPage();
        },
      ),
    );
  }
}

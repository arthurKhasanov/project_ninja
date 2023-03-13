import 'package:flutter/material.dart';
import 'package:flutter_b_ui_layout/core/app_theme/app_theme.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'auth/ui/pages/landing_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const LandingPage(),
      theme: AppTheme.appTheme.copyWith(
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: Colors.indigo,
            ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

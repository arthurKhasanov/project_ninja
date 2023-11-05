import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_b_ui_layout/auth/domain/bloc/auth_bloc/auth_bloc.dart';
import 'package:flutter_b_ui_layout/core/app_theme/app_theme.dart';
import 'package:flutter_b_ui_layout/core/dependency_injection/service_locator.dart';
import 'package:flutter_b_ui_layout/ui/routes/app_routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initDependencies();
  await Hive.initFlutter();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) => locator(),
      child: MaterialApp.router(
        theme: AppTheme.appTheme,
        debugShowCheckedModeBanner: false,
        routerConfig: AppRoutes.router,
      ),
    );
  }
}

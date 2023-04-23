import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_b_ui_layout/auth/domain/auth_repository.dart/auth_repository.dart';
import 'package:flutter_b_ui_layout/auth/domain/bloc/auth_bloc/auth_bloc.dart';
import 'package:flutter_b_ui_layout/core/network_checker/network_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../auth/data/firebase_auth_repository.dart';

final locator = GetIt.instance;

void initDependencies() {
  locator.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  locator.registerLazySingleton<NetworkChecker>(
      () => NetworkCheckerImpl(locator()));
  locator.registerLazySingleton<InternetConnectionChecker>(
      () => InternetConnectionChecker());
  locator.registerLazySingleton<AuthRepository>(() => FirebaseAuthRepository(
      firebaseAuthInstance: locator(), networkChecker: locator()));

  locator.registerSingleton<AuthBloc>(AuthBloc(authRepository: locator()));
}

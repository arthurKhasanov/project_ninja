import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../auth_core/auth_exception_handler.dart';

abstract class AuthRepository {
  Future<Either<AuthError, User>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<AuthError, User>> createUserWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<AuthError, void>> restorePassword({required String email});

  Future<Either<AuthError, User>> signInWithGoogleAccount();

  Future<void> logOut();
}

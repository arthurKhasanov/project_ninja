import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_b_ui_layout/auth/domain/auth_repository.dart/auth_repository.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../auth_core/auth_exception_handler.dart';

class FirebaseAuthRepository implements AuthRepository {
  final FirebaseAuth _firebaseInstance = FirebaseAuth.instance;

  @override
  Future<Either<AuthError, User>> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential = await _firebaseInstance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) return Right(userCredential.user!);
      return const Left(AuthError.error);
    } on FirebaseAuthException catch (error) {
      return Left(AuthExceptionHandler.determineError(error));
    } catch (e) {
      return const Left(AuthError.error);
    }
  }

  @override
  Future<Either<AuthError, User>> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final UserCredential userCredential = await _firebaseInstance
          .signInWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) return Right(userCredential.user!);
      return const Left(AuthError.userNotFound);
    } on FirebaseAuthException catch (error) {
      return Left(AuthExceptionHandler.determineError(error));
    } catch (e) {
      return const Left(AuthError.error);
    }
  }

  @override
  Future<Either<AuthError, User>> signInWithGoogleAccount() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      final UserCredential userCredential =
          await _firebaseInstance.signInWithCredential(credential);
      if (userCredential.user != null) return Right(userCredential.user!);
      return const Left(AuthError.error);
    } on FirebaseAuthException catch (error) {
      return Left(AuthExceptionHandler.determineError(error));
    } catch (e) {
      return const Left(AuthError.error);
    }
  }

  @override
  Future<Either<AuthError, void>> restorePassword({
    required String email,
  }) async {
    try {
      await _firebaseInstance.sendPasswordResetEmail(email: email);
      return const Right(null);
    } on FirebaseAuthException catch (error) {
      return Left(AuthExceptionHandler.determineError(error));
    } catch (e) {
      return const Left(AuthError.error);
    }
  }

  @override
  Future<void> logOut() async {
    await _firebaseInstance.signOut();
  }
}

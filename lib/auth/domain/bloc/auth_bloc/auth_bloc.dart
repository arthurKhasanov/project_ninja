import 'package:flutter_b_ui_layout/auth/auth_core/auth_exception_handler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../auth_repository.dart/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(UnAuthorizedState()) {
    isUserSignedIn();
    on<SignInEvent>(_singIn);
    on<SignUpEvent>(_signUp);
    on<ForgotPasswordEvent>(_restorePassword);
    on<GoogleSignUpEvent>(_googleSignUp);
    on<LogOutEvent>(_logOut);
  }

  final AuthRepository _authRepository;

  void isUserSignedIn() {
    final user = _authRepository.isUserSignedIn();

    user.fold(
      (l) => emit(UnAuthorizedState()),
      (user) => emit(AuthorizedState(user)),
    );
  }

  Future<void> _singIn(
    SignInEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _authRepository.signInWithEmailAndPassword(
      email: event.email,
      password: event.password,
    );
    _foldResult(result, emit);
  }

  Future<void> _signUp(
    SignUpEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _authRepository.createUserWithEmailAndPassword(
      email: event.email,
      password: event.password,
    );

    _foldResult(result, emit);
  }

  Future<void> _restorePassword(
    ForgotPasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _authRepository.restorePassword(
      email: event.email,
    );

    result.fold(
      (error) {
        emit(UnAuthorizedState(message: error.name));
      },
      (success) {
        emit(UnAuthorizedState(message: 'restore email'));
      },
    );
  }

  Future<void> _googleSignUp(
    GoogleSignUpEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _authRepository.signInWithGoogleAccount();

    _foldResult(result, emit);
  }

  Future<void> _logOut(LogOutEvent event, Emitter<AuthState> emit) async {
    await _authRepository.logOut();
    emit(UnAuthorizedState());
  }

  void _foldResult(Either<AuthError, User> result, Emitter<AuthState> emit) {
    result.fold(
      (error) {
        emit(UnAuthorizedState(message: error.name));
      },
      (user) {
        emit(AuthorizedState(user));
      },
    );
  }
}

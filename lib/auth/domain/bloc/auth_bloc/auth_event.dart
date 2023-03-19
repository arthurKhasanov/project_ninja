import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {}

class SignInEvent extends AuthEvent {
  final String email;
  final String password;

  SignInEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

class SignUpEvent extends AuthEvent {
  final String email;
  final String password;

  SignUpEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

class ForgotPasswordEvent extends AuthEvent {
  final String email;

  ForgotPasswordEvent({required this.email});

  @override
  List<Object?> get props => [email];
}

class GoogleSignUpEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class LogOutEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

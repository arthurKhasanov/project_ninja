import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState extends Equatable {}

class InitialState extends AuthState {
  @override
  List<Object?> get props => [];
}

class LoadingState extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthorizedState extends AuthState {
  final User user;

  AuthorizedState(this.user);
  
  @override
  List<Object?> get props => [user];
}

class ErrorState extends AuthState {
  final String message;

  ErrorState({required this.message});

  @override
  List<Object?> get props => [];
}

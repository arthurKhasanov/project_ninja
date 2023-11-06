import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState extends Equatable {}

class UnAuthorizedState extends AuthState {
  final String? message;

  UnAuthorizedState({this.message});

  @override
  List<Object?> get props => [message];
}

class AuthorizedState extends AuthState {
  final User user;

  AuthorizedState(this.user);

  @override
  List<Object?> get props => [user];
}

class LoadingState extends AuthState {
  @override
  List<Object?> get props => [];
}

import 'package:equatable/equatable.dart';

abstract class LandingAnimationEvent extends Equatable {}

class AuthStarted extends LandingAnimationEvent {
  @override
  List<Object?> get props => [];
}

class AuthCanceled extends LandingAnimationEvent {
  @override
  List<Object?> get props => [];
} 
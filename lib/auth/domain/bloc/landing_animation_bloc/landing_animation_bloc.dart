import 'package:bloc/bloc.dart';

import 'landing_animation_event.dart';

class LandingAnimationBloc extends Bloc<LandingAnimationEvent, bool> {
  LandingAnimationBloc() : super(false) {
    on<AuthStarted>(
      (event, emit) => emit(true),
    );
    on<AuthCanceled>(
      (event, emit) => emit(false),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_b_ui_layout/auth/domain/bloc/auth_bloc/auth_bloc.dart';
import 'package:flutter_b_ui_layout/auth/domain/bloc/auth_bloc/auth_event.dart';
import 'package:flutter_b_ui_layout/auth/domain/bloc/landing_animation_bloc/landing_animation_bloc.dart';
import 'package:flutter_b_ui_layout/auth/domain/bloc/landing_animation_bloc/landing_animation_event.dart';
import 'package:flutter_b_ui_layout/auth/ui/widgets/sign_up_dialog.dart';
import 'package:flutter_b_ui_layout/auth/ui/widgets/sing_in_form.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/bouncing_widget.dart';

class SignInDialog extends StatelessWidget {
  const SignInDialog({
    super.key,
  });

  Future<Object?> _signUp(BuildContext context) {
    final landingAnimationBloc = context.read<LandingAnimationBloc>();

    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Sign In',
      barrierColor: Colors.black87,
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final tween =
            Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero);
        return SlideTransition(
          position: tween.animate(
            CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn),
          ),
          child: child,
        );
      },
      pageBuilder: (context, _, __) => BlocProvider.value(
        value: landingAnimationBloc,
        child: const SignUpDialog(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<LandingAnimationBloc>().add(AuthCanceled());
        return true;
      },
      child: ScaffoldMessenger(
        child: Builder(
          builder: (context) {
            return AlertDialog(
              scrollable: true,
              clipBehavior: Clip.hardEdge,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
              backgroundColor: Colors.white.withOpacity(0.95),
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Sign In',
                    style: TextStyle(
                        color: Colors.black87,
                        fontFamily: 'Montserrat',
                        fontSize: 35),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      'To get started, please sign in with your account information below. If you\'re new here, simply create a new account to start organizing your tasks and taking control of your day.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black87, fontFamily: 'Inter', fontSize: 12),
                    ),
                  ),
                  SignInForm(
                    signIn: ({required String email, required String password}) {

                      context.read<AuthBloc>().add(SignInEvent(
                            email: email,
                            password: password,
                          ));
                    },
                    resetPassword: () {},
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: const [
                      Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'OR',
                          style:
                              TextStyle(fontFamily: 'Inter', color: Colors.black87),
                        ),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),
                  const Text(
                    'Don\'t have an account?',
                    style: TextStyle(fontFamily: 'Inter', fontSize: 12),
                  ),
                  const Text(
                    'Sign up with Email or continue with Google account',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: 'Inter', fontSize: 12),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      BouncingWidget(
                        onTap: () {
                          //TODO: add sign up with logic
                          Navigator.pop(context);
                          _signUp(context);
                          debugPrint('sign up');
                        },
                        child: Image.asset(
                          'assets/icons/auth/mail.png',
                          width: 35,
                          height: 35,
                        ),
                      ),
                      BouncingWidget(
                        onTap: () {
                          //TODO: add log in with google logic
                          Navigator.pop(context);

                          debugPrint('Google');
                        },
                        child: Image.asset(
                          'assets/icons/auth/google.png',
                          width: 35,
                          height: 35,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}

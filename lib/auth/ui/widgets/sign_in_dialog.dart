import 'package:flutter/material.dart';
import 'package:flutter_b_ui_layout/auth/domain/bloc/auth_bloc/auth_bloc.dart';
import 'package:flutter_b_ui_layout/auth/domain/bloc/auth_bloc/auth_event.dart';
import 'package:flutter_b_ui_layout/auth/domain/bloc/landing_animation_bloc/landing_animation_bloc.dart';
import 'package:flutter_b_ui_layout/auth/domain/bloc/landing_animation_bloc/landing_animation_event.dart';
import 'package:flutter_b_ui_layout/auth/ui/widgets/sign_in_header_info.dart';
import 'package:flutter_b_ui_layout/auth/ui/widgets/sign_up_dialog.dart';
import 'package:flutter_b_ui_layout/auth/ui/widgets/sign_up_info_block.dart';
import 'package:flutter_b_ui_layout/auth/ui/widgets/sing_in_form.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/bouncing_widget.dart';
import '../../domain/bloc/auth_bloc/auth_state.dart';
import 'log_in_dialog_divider.dart';

class SignInDialog extends StatelessWidget {
  const SignInDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthorizedState) {
          Navigator.pop(context);
        }
      },
      child: WillPopScope(
        onWillPop: () async {
          context.read<LandingAnimationBloc>().add(AuthCanceled());
          return true;
        },
        child: ScaffoldMessenger(
          child: Builder(builder: (context) {
            return AlertDialog(
              scrollable: true,
              clipBehavior: Clip.hardEdge,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
              backgroundColor: Colors.white.withOpacity(0.95),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SignInHeaderInfo(),
                  SignInForm(
                    signIn: ({
                      required String email,
                      required String password,
                    }) {
                      context.read<AuthBloc>().add(
                            SignInEvent(
                              email: email,
                              password: password,
                            ),
                          );
                    },
                    resetPassword: () {},
                  ),
                  const LogInDialogDivider(),
                  const SignUpInfoBlock(),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}

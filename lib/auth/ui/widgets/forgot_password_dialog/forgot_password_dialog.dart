import 'package:flutter/material.dart';
import 'package:flutter_b_ui_layout/auth/ui/widgets/forgot_password_dialog/forgot_password_form.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/bloc/landing_animation_bloc/landing_animation_bloc.dart';
import '../../../domain/bloc/landing_animation_bloc/landing_animation_event.dart';
import 'forgot_password_header.dart';

class ForgotPasswordDialog extends StatelessWidget {
  const ForgotPasswordDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<LandingAnimationBloc>().add(AuthCanceled());
        return true;
      },
      child: AlertDialog(
        scrollable: true,
        clipBehavior: Clip.hardEdge,
        contentPadding:
            const EdgeInsets.only(top: 32, left: 24, right: 24, bottom: 24),
        backgroundColor: Colors.white.withOpacity(0.95),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            ForgotPasswordHeaderInfo(),
            ForgotPasswordForm(),
          ],
        ),
      ),
    );
  }
}

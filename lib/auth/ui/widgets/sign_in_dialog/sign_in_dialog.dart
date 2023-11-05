import 'package:flutter/material.dart';
import 'package:flutter_b_ui_layout/auth/domain/bloc/landing_animation_bloc/landing_animation_bloc.dart';
import 'package:flutter_b_ui_layout/auth/domain/bloc/landing_animation_bloc/landing_animation_event.dart';
import 'package:flutter_b_ui_layout/auth/ui/widgets/sign_in_dialog/sign_in_header_info.dart';
import 'package:flutter_b_ui_layout/auth/ui/widgets/sign_in_dialog/sing_in_form.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../log_in_dialog_divider.dart';
import '../sign_up_dialog/sign_up_info_block.dart';

class SignInDialog extends StatelessWidget {
  const SignInDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<LandingAnimationBloc>().add(AuthCanceled());
        return true;
      },
      child: SafeArea(
        child: AlertDialog(
          scrollable: true,
          clipBehavior: Clip.hardEdge,
          contentPadding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
          backgroundColor: Colors.white.withOpacity(0.95),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SignInHeaderInfo(),
              SignInForm(),
              LogInDialogDivider(),
              SignUpInfoBlock(),
            ],
          ),
        ),
      ),
    );
  }
}

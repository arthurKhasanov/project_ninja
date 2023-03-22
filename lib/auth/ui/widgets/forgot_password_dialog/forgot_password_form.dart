import 'package:flutter/material.dart';
import 'package:flutter_b_ui_layout/auth/domain/bloc/auth_bloc/auth_event.dart';
import 'package:flutter_b_ui_layout/auth/domain/bloc/auth_bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rive/rive.dart';

import '../../../domain/bloc/auth_bloc/auth_bloc.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({
    super.key,
  });

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  late final GlobalKey<FormState> _formKey;

  late final TextEditingController _emailController;

  late final FocusNode _emailFocusNode;

  String? _firebaseAnswer;

  late SMITrigger _check;
  late SMITrigger _error;

  bool _isLoadingAnimationOnScreen = false;

  StateMachineController _getRiveController(Artboard artboard) {
    StateMachineController? controller =
        StateMachineController.fromArtboard(artboard, 'State Machine 1');
    artboard.addController(controller!);
    return controller;
  }

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _emailFocusNode = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _emailFocusNode.dispose();

    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email address';
    }
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Please enter a valid email address';
    }

    return _firebaseAnswer;
  }

  void _addMessageToValidationAnswer(String message) {
    switch (message) {
      case 'invalidEmail':
        _firebaseAnswer = 'Please enter a valid email address';
        break;
      case 'userDisabled':
        _firebaseAnswer = 'User disabled';
        break;
      case 'userNotFound':
        _firebaseAnswer = 'User with this email doesn\'t exist';
        break;
      default:
        _firebaseAnswer = 'Error';
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is UnAuthorizedState) {
          if (state.message != 'restore email') {
            _error.fire();

            await Future.delayed(const Duration(seconds: 2)).whenComplete(
              () {
                setState(
                  () => _isLoadingAnimationOnScreen = false,
                );
              },
            );

            _addMessageToValidationAnswer(state.message!);

            _formKey.currentState!.validate();
            _firebaseAnswer = null;
          } else {
            _check.fire();

            await Future.delayed(const Duration(seconds: 2)).whenComplete(
              () {
                setState(
                  () => _isLoadingAnimationOnScreen = false,
                );
                _firebaseAnswer = null;
                Navigator.pop(context);
              },
            );
          }
        }
      },
      child: Stack(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _emailController,
                  focusNode: _emailFocusNode,
                  textInputAction: TextInputAction.next,
                  validator: _validateEmail,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                    prefixIcon: Icon(FontAwesomeIcons.envelope),
                  ),
                  onFieldSubmitted: (value) {
                    _emailFocusNode.unfocus();
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        _isLoadingAnimationOnScreen = true;
                      });
                      context.read<AuthBloc>().add(
                            ForgotPasswordEvent(
                              email: _emailController.text.trim(),
                            ),
                          );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.circular(4),
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                  ),
                  icon: const Icon(FontAwesomeIcons.arrowRight),
                  label: const Text(
                    'Reset password',
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          _isLoadingAnimationOnScreen
              ? Positioned.fill(
                  child: Column(
                    children: [
                      const Spacer(),
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: RiveAnimation.asset(
                          'assets/rive_animations/auth/loading.riv',
                          onInit: (artboard) {
                            final StateMachineController controller =
                                _getRiveController(artboard);
                            _check = controller.findSMI('Check') as SMITrigger;
                            _error = controller.findSMI('Error') as SMITrigger;
                          },
                        ),
                      ),
                      const Spacer(flex: 2),
                    ],
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}

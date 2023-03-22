import 'package:flutter/material.dart';
import 'package:flutter_b_ui_layout/auth/domain/bloc/auth_bloc/auth_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rive/rive.dart';

import '../../../domain/bloc/auth_bloc/auth_bloc.dart';
import '../../../domain/bloc/auth_bloc/auth_state.dart';
import '../../../domain/bloc/landing_animation_bloc/landing_animation_bloc.dart';
import '../custom_positioned_widget.dart';
import '../forgot_password_dialog/forgot_password_dialog.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  late final GlobalKey<FormState> _formKey;

  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  late final FocusNode _emailFocusNode;
  late final FocusNode _passwordFocusNode;
  late final FocusNode _submitFocusNode;

  String? firebaseEmailAnswer;
  String? firebasePasswordAnswer;

  late SMITrigger check;
  late SMITrigger error;
  late SMITrigger reset;

  bool isLoadingAnimationOnScreen = false;

  StateMachineController getRiveController(Artboard artboard) {
    StateMachineController? controller =
        StateMachineController.fromArtboard(artboard, 'State Machine 1');
    artboard.addController(controller!);
    return controller;
  }

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _submitFocusNode = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _submitFocusNode.dispose();
    super.dispose();
  }

  Future<Object?> _resetPassword(BuildContext context) {
    final authBloc = context.read<AuthBloc>();
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
        pageBuilder: (context, _, __) => MultiBlocProvider(
              providers: [
                BlocProvider<LandingAnimationBloc>.value(
                  value: landingAnimationBloc,
                ),
                BlocProvider<AuthBloc>.value(
                  value: authBloc,
                ),
              ],
              child: const ForgotPasswordDialog(),
            ));
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email address';
    }
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return firebaseEmailAnswer;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    return firebasePasswordAnswer;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is UnAuthorizedState) {
          debugPrint(state.message);
          if (state.message == null) return;

          error.fire();

          await Future.delayed(const Duration(seconds: 2)).whenComplete(
            () {
              setState(
                () => isLoadingAnimationOnScreen = false,
              );
            },
          );

          switch (state.message) {
            case 'invalidEmail':
              firebaseEmailAnswer = 'Please enter a valid email address';
              break;
            case 'userDisabled':
              firebaseEmailAnswer = 'User disabled';
              break;
            case 'userNotFound':
              firebaseEmailAnswer = 'User with this email doesn\'t exist';
              break;
            case 'wrongPassword':
              firebasePasswordAnswer = 'Wrong password';
              break;
            case 'emailAlreadyInUse':
              firebaseEmailAnswer = 'Email already in use';
              break;
            case 'weakPassword':
              firebaseEmailAnswer =
                  'Password must contain at least 6 characters';
              break;
            default:
              firebasePasswordAnswer = 'Error';
              break;
          }

          _formKey.currentState!.validate();
          firebaseEmailAnswer = null;
          firebasePasswordAnswer = null;
        } else {
          check.fire();

          await Future.delayed(const Duration(seconds: 2)).whenComplete(
            () {
              setState(
                () => isLoadingAnimationOnScreen = false,
              );
              firebaseEmailAnswer = null;
              firebasePasswordAnswer = null;
              Navigator.pop(context);
            },
          );
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
                    _passwordFocusNode.requestFocus();
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _passwordController,
                  focusNode: _passwordFocusNode,
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  validator: _validatePassword,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                    prefixIcon: Icon(
                      FontAwesomeIcons.lock,
                    ),
                  ),
                  onFieldSubmitted: (value) {
                    _passwordFocusNode.unfocus();
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      _resetPassword(context);
                    },
                    child: Text(
                      'Forgot Password?',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton.icon(
                  focusNode: _submitFocusNode,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      setState(
                        () => isLoadingAnimationOnScreen = true,
                      );

                      context.read<AuthBloc>().add(
                            SignInEvent(
                              email: _emailController.text.trim(),
                              password: _passwordController.text.trim(),
                            ),
                          );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                        bottomLeft: Radius.circular(4),
                        bottomRight: Radius.circular(4),
                      ),
                    ),
                  ),
                  icon: const Icon(FontAwesomeIcons.arrowRight),
                  label: const Text(
                    'Sign In',
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          isLoadingAnimationOnScreen
              ? CustomPositionedWidget(
                  child: RiveAnimation.asset(
                    'assets/rive_animations/auth/loading.riv',
                    onInit: (artboard) {
                      final StateMachineController controller =
                          getRiveController(artboard);
                      check = controller.findSMI('Check') as SMITrigger;
                      error = controller.findSMI('Error') as SMITrigger;
                      reset = controller.findSMI('Reset') as SMITrigger;
                    },
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../domain/bloc/auth_bloc/auth_bloc.dart';
import '../../../domain/bloc/auth_bloc/auth_state.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    super.key,
    required this.signUp,
  });

  final void Function({required String email, required String password}) signUp;

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  late final GlobalKey<FormState> _formKey;

  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  late final FocusNode _emailFocusNode;
  late final FocusNode _passwordFocusNode;

  String? firebaseEmailAnswer;
  String? firebasePasswordAnswer;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
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
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is UnAuthorizedState) {
          
          if (state.message == null) return;

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
        } else {
          firebaseEmailAnswer = null;
          firebasePasswordAnswer = null;
        }
      },
      child: Form(
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
              height: 16,
            ),
            ElevatedButton.icon(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  widget.signUp(
                      email: _emailController.text.trim(),
                      password: _passwordController.text.trim());
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
                'Sign Up',
                style: TextStyle(fontFamily: 'Montserrat', fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

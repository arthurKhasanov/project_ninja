import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({
    super.key,
    required this.signIn,
    required this.resetPassword,
  });

  final VoidCallback signIn;
  final VoidCallback resetPassword;

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

  // void _signInWithEmail() async {
  //   try {
  //     final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
  //         email: _emailController.text, password: _passwordController.text);
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'user-not-found') {
  //       print('No user found for that email.');
  //     } else if (e.code == 'wrong-password') {
  //       print('Wrong password provided for that user.');
  //     }
  //   }
  // }

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
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
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
              FocusScope.of(context).requestFocus(_submitFocusNode);
            },
          ),
          const SizedBox(
            height: 8,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: widget.resetPassword,
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
                widget.signIn();
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
    );
  }
}

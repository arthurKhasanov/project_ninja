import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({
    super.key,
    required this.forgotPassword,
  });

  final void Function({required String email}) forgotPassword;

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  late final GlobalKey<FormState> _formKey;

  late final TextEditingController _emailController;

  late final FocusNode _emailFocusNode;

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
                widget.forgotPassword(
                  email: _emailController.text.trim(),
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
    );
  }
}
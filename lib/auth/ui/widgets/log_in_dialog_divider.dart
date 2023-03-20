import 'package:flutter/material.dart';

class LogInDialogDivider extends StatelessWidget {
  const LogInDialogDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: const [
        Expanded(child: Divider()),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'OR',
            style: TextStyle(fontFamily: 'Inter', color: Colors.black87),
          ),
        ),
        Expanded(child: Divider()),
      ],
    );
  }
}
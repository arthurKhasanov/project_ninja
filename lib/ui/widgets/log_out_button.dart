import 'package:flutter/material.dart';
import 'package:flutter_b_ui_layout/auth/domain/bloc/auth_bloc/auth_bloc.dart';
import 'package:flutter_b_ui_layout/auth/domain/bloc/auth_bloc/auth_event.dart';
import 'package:flutter_b_ui_layout/core/dependency_injection/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LogOutButton extends StatefulWidget {
  const LogOutButton({
    super.key,
  });

  @override
  State<LogOutButton> createState() => _LogOutButtonState();
}

class _LogOutButtonState extends State<LogOutButton> {
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 16),
          child: Divider(
            color: Colors.white24,
            height: 1,
          ),
        ),
        Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              curve: Curves.fastOutSlowIn,
              left: 0,
              width: isActive ? 280 : 0,
              child: Container(
                height: 54,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color.fromARGB(255, 99, 117, 251)),
              ),
            ),
            ListTile(
              onTap: () async {
                setState(() {
                  isActive = !isActive;
                });
                await Future.delayed(const Duration(milliseconds: 200))
                    .whenComplete(
                  () => 
                  locator<AuthBloc>().add(LogOutEvent()),
                );
              },
              leading: const Icon(
                FontAwesomeIcons.arrowRightFromBracket,
                color: Colors.white,
              ),
              title: const Text(
                'Log Out',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({
    super.key,
    required this.isSideMenuShowed,
    required this.onTap,
  });

  final bool isSideMenuShowed;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SafeArea(
        child: Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, 3),
                blurRadius: 8,
              ),
            ],
          ),
          child: Center(
            child: AnimatedCrossFade(
              duration: const Duration(milliseconds: 300),
              crossFadeState: isSideMenuShowed
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              firstChild: const Icon(Icons.menu),
              secondChild: const Icon(Icons.close),
            ),
          ),
        ),
      ),
    );
  }
}

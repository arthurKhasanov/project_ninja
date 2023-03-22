import 'package:flutter/material.dart';

class BouncingWidget extends StatefulWidget {
  const BouncingWidget({super.key, required this.onTap, required this.child});
  final Widget child;
  final VoidCallback onTap;

  @override
  State<BouncingWidget> createState() => _BouncingWidgetState();
}

class _BouncingWidgetState extends State<BouncingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 100))
      ..addListener(() {
        setState(() {});
      });

    _scaleAnimation = Tween<double>(begin: 1, end: 0.9).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await _animationController.forward();
        await _animationController.reverse();
        widget.onTap();
      },
      child: Transform.scale(
        scale: _scaleAnimation.value,
        child: widget.child,
      ),
    );
  }
}

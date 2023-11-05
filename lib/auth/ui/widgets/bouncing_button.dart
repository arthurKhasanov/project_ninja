import 'package:flutter/material.dart';

class BouncingButton extends StatefulWidget {
  const BouncingButton({super.key, required this.onTap, required this.child});

  final VoidCallback onTap;
  final Widget child;

  @override
  State<BouncingButton> createState() => _BouncingButtonState();
}

class _BouncingButtonState extends State<BouncingButton>
    with SingleTickerProviderStateMixin {
      
  late Animation<double> _scaleAnimation;
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 200,
      ),
    )..addListener(() {
        setState(() {});
      });
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.fastOutSlowIn));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
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
        child: Container(
          height: 54,
          width: MediaQuery.of(context).size.width - 32,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.indigo,
                  Colors.purple,
                ],
              )),
          child: Center(
            child: widget.child,
          ),
        ),
      ),
    );
  }
}

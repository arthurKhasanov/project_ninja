import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_b_ui_layout/widgets/menu_button.dart';
import 'package:flutter_b_ui_layout/widgets/home_screen.dart';
import 'package:flutter_b_ui_layout/widgets/side_menu.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const InitialScreen(),
      theme: ThemeData(useMaterial3: true),
    );
  }
}

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen>
    with SingleTickerProviderStateMixin {
  bool isSideMenuClosed = true;
  late AnimationController animationController;
  late Animation<double> animation;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200))
      ..addListener(() {
        setState(() {});
      });
    animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn));
    scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn));
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 17, 0, 63),
      body: Stack(
        children: [
          AnimatedPositioned(
            width: 288,
            left: isSideMenuClosed ? -288 : 0,
            height: MediaQuery.of(context).size.height,
            duration: const Duration(milliseconds: 200),
            curve: Curves.fastOutSlowIn,
            child: SideMenu(),
          ),
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(animation.value - 30 * animation.value * pi / 180),
            child: Transform.translate(
              offset: Offset(animation.value * 288, 0),
              child: Transform.scale(
                scale: scaleAnimation.value,
                child: GestureDetector(
                  onTap: () {
                    if (!isSideMenuClosed) {
                      animationController.reverse();
                      setState(() {
                        isSideMenuClosed = !isSideMenuClosed;
                      });
                    }
                  },
                  child: AnimatedContainer(
                    clipBehavior: Clip.hardEdge,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.fastOutSlowIn,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.only(
                        topStart: Radius.circular(isSideMenuClosed ? 0 : 24),
                        bottomStart: Radius.circular(isSideMenuClosed ? 0 : 24),
                      ),
                    ),
                    child: const TasksScreen(),
                  ),
                ),
              ),
            ),
          ),
          AnimatedPadding(
            curve: Curves.fastOutSlowIn,
            padding:
                EdgeInsets.only(left: isSideMenuClosed ? 16 : 236, top: 16),
            duration: const Duration(milliseconds: 200),
            child: MenuButton(
              animationController: animationController,
              onTap: () {
                if (isSideMenuClosed) {
                  animationController.forward();
                } else {
                  animationController.reverse();
                }
                setState(() {
                  isSideMenuClosed = !isSideMenuClosed;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

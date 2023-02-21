import 'package:flutter/material.dart';
import 'package:flutter_b_ui_layout/widgets/side_menu.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'menu_button.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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

class _InitialScreenState extends State<InitialScreen> {
  bool isSideMenuShowed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 17, 0, 63),
      body: Stack(
        children: [
          Positioned(
            width: 288,
            height: MediaQuery.of(context).size.height,
            child: SideMenu(),
          ),
          Transform.translate(
            offset: const Offset(288, 0),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: ListView.separated(
                itemBuilder: (context, index) => Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '$index Hello there! I\'m ready! No way back!',
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                itemCount: 30,
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(
                  height: 8,
                ),
              ),
            ),
          ),
          MenuButton(
            isSideMenuShowed: isSideMenuShowed,
            onTap: () {
              setState(() {
                isSideMenuShowed = !isSideMenuShowed;
              });
            },
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_b_ui_layout/ui/routes/app_routes.dart';
import 'package:go_router/go_router.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        shrinkWrap: true,
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
        separatorBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return ElevatedButton(
                onPressed: () {
                  context.push(AppPages.addTask.path);
                },
                child: const Text('Add task'));
          }
          return const SizedBox(
            height: 8,
          );
        },
      ),
    );
  }
}

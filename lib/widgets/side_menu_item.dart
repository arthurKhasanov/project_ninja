import 'package:flutter/material.dart';
import 'package:flutter_b_ui_layout/domain/model/project.dart';

class SideMenuItem extends StatelessWidget {
  const SideMenuItem({
    super.key,
    required this.project,
    required this.onTap,
    required this.isActive,
  });

  final Project project;
  final VoidCallback onTap;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
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
                width: isActive ? 288 : 0,
                child: Container(
                  height: 54,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color.fromARGB(255, 99, 117, 251)),
                ),
              ),
              ListTile(
                onTap: onTap,
                leading: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(
                        14,
                      ),
                    ),
                    height: 28,
                    width: 28,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                        value: _projectProgress(),
                      ),
                    )),
                title: Text(
                  project.title,
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  double _projectProgress() {
    int doneTasksCount = 0;
    for (var task in project.tasks) {
      if (task.isDone) doneTasksCount++;
    }
    return doneTasksCount == 0 ? 0 : doneTasksCount / project.tasks.length;
  }
}

import 'package:flutter_b_ui_layout/domain/model/task.dart';

class Project {
  final int id;
  final String title;
  final List<Task> tasks;

  Project({
    required this.id,
    required this.title,
    required this.tasks,
  });
}

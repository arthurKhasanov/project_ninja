import 'package:flutter_b_ui_layout/domain/model/task.dart';

class ProjectModel {
  final int id;
  final String title;
  final List<TaskModel> tasks;

  ProjectModel({
    required this.id,
    required this.title,
    required this.tasks,
  });
}

import 'package:flutter/widgets.dart';

class TaskModel {
  final int id;
  final String title;
  final String? description;
  final DateTime? dateStart;
  final DateTime? dateFinish;
  final Color? color;
  final bool isDone;
  final int priority;

  TaskModel({
    required this.id,
    required this.title,
    this.description,
    this.dateStart,
    this.dateFinish,
    this.color,
    this.isDone = false,
    this.priority = 0,
  });
}

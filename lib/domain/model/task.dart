class Task {
  final int id;
  final String title;
  final String description;
  final DateTime dateFinish;
  final bool isDone;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.dateFinish,
    required this.isDone,
  });
}

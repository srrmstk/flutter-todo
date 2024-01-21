class TodoItem {
  TodoItem({
    required this.title,
    required this.date,
    this.description,
  });

  String title;
  String? description;
  DateTime date;
  bool isDone = false;
}

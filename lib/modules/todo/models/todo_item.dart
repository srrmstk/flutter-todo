import 'package:uuid/uuid.dart';

class TodoItem {
  TodoItem({
    required this.title,
    required this.date,
    this.description,
  }) : id = const Uuid().v4();

  final String id;
  String title;
  String? description;
  DateTime date;
  bool isDone = false;
}

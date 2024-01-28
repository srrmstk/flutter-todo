import 'package:todo/modules/todo/data/todo_schema.dart';
import 'package:uuid/uuid.dart';

class TodoItem {
  TodoItem(
      {required this.title,
      required this.date,
      this.description,
      String? id,
      bool? isDone})
      : id = id ?? const Uuid().v4(),
        isDone = isDone ?? false;

  TodoItem.fromIsar(Todo schema)
      : id = schema.id ?? '',
        title = schema.title ?? '',
        date = schema.date ?? DateTime.now(),
        description = schema.description ?? '',
        isDone = schema.isDone ?? false;

  final String id;
  String title;
  String? description;
  DateTime date;
  bool isDone = false;
}

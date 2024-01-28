import 'package:isar/isar.dart';
import 'package:todo/common/isar_helper.dart';

part 'todo_schema.g.dart';

@collection
class Todo {
  String? id;
  Id get isarId => IsarHelper.fastHash(id!);
  String? title;
  String? description;
  DateTime? date;
  bool? isDone;
}

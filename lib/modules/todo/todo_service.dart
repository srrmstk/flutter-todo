import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:todo/modules/todo/data/todo_schema.dart';
import 'package:todo/modules/todo/models/todo_item.dart';

class TodoService {
  TodoService();

  final Isar isar = GetIt.instance<Isar>();

  Future<List<TodoItem>> initTodoList() async {
    final collection = await isar.todos.where().findAll();

    final res = <TodoItem>[];

    for (final e in collection) {
      res.add(TodoItem.fromIsar(e));
    }

    return res;
  }

  Future<void> putTodo(TodoItem todoItem) async {
    final item = _constructTodoSchema(todoItem);

    await isar.writeTxn(() async {
      await isar.todos.put(item);
    });
  }

  Future<void> deleteTodo(String id) async {
    await isar.writeTxn(() async {
      await isar.todos.filter().idEqualTo(id).deleteAll();
    });
  }

  Future<void> reorderTodo() async {
    // @TODO: make reorder logic, e.g. by adding sort field to schema
  }

  Todo _constructTodoSchema(TodoItem todoItem) {
    return Todo()
      ..id = todoItem.id
      ..title = todoItem.title
      ..description = todoItem.description
      ..date = todoItem.date
      ..isDone = todoItem.isDone;
  }
}

part of 'todo_list_bloc.dart';

@immutable
abstract class TodoListEvent {}

class TodoListItemAdded extends TodoListEvent {
  TodoListItemAdded(this.todoItem);

  final TodoItem todoItem;
}

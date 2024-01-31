part of 'todo_list_bloc.dart';

class TodoListState {
  TodoListState({required this.todoList});

  final List<TodoItem> todoList;

  TodoListState copyWith({
    List<TodoItem>? todoList,
  }) {
    return TodoListState(todoList: todoList ?? this.todoList);
  }
}

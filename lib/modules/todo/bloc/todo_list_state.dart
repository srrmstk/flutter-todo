part of 'todo_list_bloc.dart';

class TodoListState {
  final List<TodoItem> todoList;

  TodoListState({required this.todoList});

  TodoListState copyWith({
    List<TodoItem>? todoList,
  }) {
    return TodoListState(todoList: todoList ?? this.todoList);
  }
}

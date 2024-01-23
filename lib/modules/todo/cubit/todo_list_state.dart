part of 'todo_list_cubit.dart';

class TodoListCubitState {
  final List<TodoItem> todoList;

  TodoListCubitState({required this.todoList});

  TodoListCubitState copyWith({
    List<TodoItem>? todoList,
  }) {
    return TodoListCubitState(todoList: todoList ?? this.todoList);
  }
}

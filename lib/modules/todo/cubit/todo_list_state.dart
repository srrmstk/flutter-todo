part of 'todo_list_cubit.dart';

class TodoListCubitState {
  TodoListCubitState({
    required this.todoList,
    required this.isLoading,
    this.currentTodo,
  });

  final List<TodoItem> todoList;
  final TodoItem? currentTodo;
  final bool isLoading;

  TodoListCubitState copyWith({
    List<TodoItem>? todoList,
    TodoItem? currentTodo,
    bool? isLoading,
  }) {
    return TodoListCubitState(
      todoList: todoList ?? this.todoList,
      currentTodo: currentTodo ?? this.currentTodo,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

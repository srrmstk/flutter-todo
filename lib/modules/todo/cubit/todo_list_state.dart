part of 'todo_list_cubit.dart';

class TodoListCubitState {
  final List<TodoItem> todoList;
  final TodoItem? currentTodo;

  TodoListCubitState({required this.todoList, this.currentTodo});

  TodoListCubitState copyWith({
    List<TodoItem>? todoList,
    TodoItem? currentTodo,
  }) {
    return TodoListCubitState(
      todoList: todoList ?? this.todoList,
      currentTodo: currentTodo ?? this.currentTodo,
    );
  }
}

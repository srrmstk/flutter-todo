import 'package:bloc/bloc.dart';
import 'package:todo/modules/todo/models/todo_item.dart';

part 'todo_list_state.dart';

class TodoListCubit extends Cubit<TodoListCubitState> {
  TodoListCubit() : super(TodoListCubitState(todoList: []));

  addTodo(TodoItem item) {
    final todoList = state.todoList..add(item);
    emit(state.copyWith(todoList: todoList));
  }

  deleteTodo(String id) {
    final todoList = state.todoList..removeWhere((element) => element.id == id);
    emit(state.copyWith(todoList: todoList));
  }

  editTodo(TodoItem item) {
    final index = state.todoList.indexWhere((todo) => todo.id == item.id);

    if (index == -1) {
      return;
    }

    final todoList = state.todoList;
    todoList[index] = item;

    emit(state.copyWith(todoList: todoList));
  }

  getTodoById(String? id) {
    final todo = state.todoList.firstWhere((todo) => todo.id == id);
    setCurrentTodo(todo);
  }

  setCurrentTodo(TodoItem? todo) {
    emit(state.copyWith(currentTodo: todo));
  }
}

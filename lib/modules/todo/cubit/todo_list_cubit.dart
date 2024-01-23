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
}

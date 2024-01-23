import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo/modules/todo/models/todo_item.dart';

part 'todo_list_event.dart';
part 'todo_list_state.dart';

class TodoListBloc extends Bloc<TodoListEvent, TodoListState> {
  TodoListBloc() : super(TodoListState(todoList: [])) {
    on<TodoListItemAdded>((event, emit) {
      final todoList = state.todoList..add(event.todoItem);
      emit(state.copyWith(todoList: todoList));
    });

    on<TodoListItemDeleted>((event, emit) {
      final todoList = state.todoList
        ..removeWhere((element) => element.id == event.id);

      emit(state.copyWith(todoList: todoList));
    });
  }
}

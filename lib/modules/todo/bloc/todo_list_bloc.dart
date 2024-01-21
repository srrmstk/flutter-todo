import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo/modules/todo/models/todo_item.dart';

part 'todo_list_event.dart';
part 'todo_list_state.dart';

class TodoListBloc extends Bloc<TodoListEvent, TodoListState> {
  TodoListBloc()
      : super(TodoListState([
          TodoItem(
            title: 'jopa',
            date: DateTime.now(),
          ),
          TodoItem(
            title: 'jopa',
            date: DateTime.now(),
          ),
          TodoItem(
            title: 'jopa',
            date: DateTime.now(),
          ),
          TodoItem(
            title: 'jopa',
            date: DateTime.now(),
          ),
          TodoItem(
            title: 'jopa',
            date: DateTime.now(),
          ),
        ])) {
    on<TodoListItemAdded>((event, emit) {
      final newTodoList = state.todoList;
      newTodoList.add(event.todoItem);

      emit(TodoListState(newTodoList));
    });
  }
}

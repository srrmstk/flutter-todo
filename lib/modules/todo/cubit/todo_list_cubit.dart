import 'package:bloc/bloc.dart';
import 'package:todo/modules/todo/models/todo_item.dart';
import 'package:todo/modules/todo/todo_service.dart';

part 'todo_list_state.dart';

class TodoListCubit extends Cubit<TodoListCubitState> {
  TodoListCubit()
      : super(
          TodoListCubitState(
            todoList: [],
            isLoading: false,
          ),
        );

  final TodoService todoService = TodoService();

  Future<void> initTodoList() async {
    emit(state.copyWith(isLoading: true));

    final todoList = await todoService.initTodoList();
    emit(state.copyWith(todoList: todoList, isLoading: false));
  }

  Future<void> addTodo(TodoItem item) async {
    final todoList = state.todoList..add(item);

    await todoService.putTodo(item);
    emit(state.copyWith(todoList: todoList));
  }

  Future<void> deleteTodo(String id) async {
    final todoList = state.todoList..removeWhere((element) => element.id == id);

    await todoService.deleteTodo(id);
    emit(state.copyWith(todoList: todoList));
  }

  Future<void> editTodo(TodoItem item) async {
    final index = state.todoList.indexWhere((todo) => todo.id == item.id);

    if (index == -1) {
      return;
    }

    final todoList = state.todoList;
    todoList[index] = item;

    await todoService.putTodo(item);
    emit(state.copyWith(todoList: todoList));
  }

  Future<void> reorderTodo(int from, int to) async {
    var localTo = to;

    if (from < localTo) {
      localTo -= 1;
    }

    final todoList = state.todoList;
    final element = todoList.removeAt(from);
    todoList.insert(localTo, element);

    await todoService.reorderTodo();
    emit(state.copyWith(todoList: todoList));
  }

  void getTodoById(String? id) {
    final todo = state.todoList.firstWhere((todo) => todo.id == id);
    setCurrentTodo(todo);
  }

  void setCurrentTodo(TodoItem? todo) {
    emit(state.copyWith(currentTodo: todo));
  }
}

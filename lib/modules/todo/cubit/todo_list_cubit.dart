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

  final TodoService _todoService = TodoService();

  Future<void> initTodoList() async {
    emit(state.copyWith(isLoading: true));

    final todoList = await _todoService.initTodoList();
    emit(state.copyWith(todoList: todoList, isLoading: false));
  }

  Future<void> addTodo(TodoItem item) async {
    final todoList = state.todoList..add(item);

    await _todoService.putTodo(item);
    _updateTodoList(todoList);
  }

  Future<void> deleteTodo(String id) async {
    final updatedTodoList = state.todoList
      ..removeWhere((element) => element.id == id);

    await _todoService.deleteTodo(id);
    _updateTodoList(updatedTodoList);
  }

  Future<void> editTodo(TodoItem item) async {
    final index = state.todoList.indexWhere((todo) => todo.id == item.id);

    if (index == -1) {
      return;
    }

    final updatedTodoList = state.todoList;
    updatedTodoList[index] = item;

    await _todoService.putTodo(item);
    _updateTodoList(updatedTodoList);
  }

  Future<void> reorderTodo(int from, int to) async {
    if (from == to) return;

    final updatedTodoList = [...state.todoList];
    final element = updatedTodoList.removeAt(from);
    updatedTodoList.insert(to > from ? to - 1 : to, element);

    await _todoService.reorderTodo();
    _updateTodoList(updatedTodoList);
  }

  void getTodoById(String? id) {
    final todo = state.todoList.firstWhere((todo) => todo.id == id);
    setCurrentTodo(todo);
  }

  void setCurrentTodo(TodoItem? todo) {
    emit(state.copyWith(currentTodo: todo));
  }

  void _updateTodoList(List<TodoItem> updatedTodoList) {
    emit(state.copyWith(todoList: updatedTodoList));
  }
}

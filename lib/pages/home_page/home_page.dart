import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/modules/todo/cubit/todo_list_cubit.dart';
import 'package:todo/modules/todo/models/todo_item.dart';
import 'package:todo/navigation/router.dart';
import 'package:todo/navigation/screen_names.dart';
import 'package:todo/pages/home_page/widgets/todo_list_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _onEdit(String id) {
    _handleNavigation(ScreenNames.createPage, {
      'id': id,
    });
  }

  void _onDelete(String id, TodoListCubit cubit) {
    cubit.deleteTodo(id);
    // BlocProvider.of<TodoListBloc>(context).add(TodoListItemDeleted(id));
  }

  void _onDoneChange(String id, TodoListCubit cubit) {
    final itemToChange = cubit.state.todoList.firstWhere((e) => e.id == id);

    cubit.editTodo(
      TodoItem(
          id: itemToChange.id,
          title: itemToChange.title,
          description: itemToChange.description,
          date: itemToChange.date,
          isDone: !itemToChange.isDone),
    );
  }

  Future<void> _onRefresh(TodoListCubit cubit) async {
    await cubit.initTodoList();
  }

  void _onReorder(int from, int to, TodoListCubit cubit) async {
    await cubit.reorderTodo(from, to);
  }

  void _handleNavigation(String routeName, Map<String, dynamic>? args) {
    AppNavigator.instance.push(routeName, args);
  }

  @override
  Widget build(BuildContext context) {
    final TodoListCubit cubit = BlocProvider.of<TodoListCubit>(context)
      ..initTodoList();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Список дел'),
        actions: [
          IconButton(
            onPressed: () => _handleNavigation(ScreenNames.createPage, null),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<TodoListCubit, TodoListCubitState>(
          bloc: cubit,
          builder: (context, state) {
            return Column(
              children: [
                state.isLoading
                    ? const LinearProgressIndicator(minHeight: 4)
                    : const SizedBox(height: 4),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () => _onRefresh(cubit),
                    child: ReorderableListView.builder(
                      onReorder: (from, to) => _onReorder(from, to, cubit),
                      itemCount: state.todoList.length,
                      itemBuilder: (context, index) => TodoListItem(
                        key: ValueKey(index),
                        onEdit: (id) => _onEdit(id),
                        onDelete: (id) => _onDelete(id, cubit),
                        onDoneChange: (id) => _onDoneChange(id, cubit),
                        todoItem: state.todoList[index],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/modules/todo/cubit/todo_list_cubit.dart';
import 'package:todo/modules/todo/models/todo_item.dart';
import 'package:todo/navigation/router.dart';
import 'package:todo/navigation/screen_names.dart';
import 'package:todo/pages/home_page/widgets/todo_list_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final TodoListCubit _cubit;

  void _onEdit(String id) {
    _handleNavigation(ScreenNames.createPage, {'id': id});
  }

  void _onDelete(String id) {
    _cubit.deleteTodo(id);
  }

  void _onDoneChange(String id) {
    final itemToChange = _cubit.state.todoList.firstWhere((e) => e.id == id);

    _cubit.editTodo(
      TodoItem(
        id: itemToChange.id,
        title: itemToChange.title,
        description: itemToChange.description,
        date: itemToChange.date,
        isDone: !itemToChange.isDone,
      ),
    );
  }

  Future<void> _onRefresh() async {
    await _cubit.initTodoList();
  }

  Future<void> _onReorder(int from, int to) async {
    await _cubit.reorderTodo(from, to);
  }

  void _handleNavigation(String routeName, Map<String, dynamic>? args) {
    AppNavigator.instance.push(routeName, args);
  }

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<TodoListCubit>(context)..initTodoList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Todo List'),
        actions: [
          IconButton(
            onPressed: () => _handleNavigation(ScreenNames.createPage, null),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<TodoListCubit, TodoListCubitState>(
          bloc: _cubit,
          builder: (context, state) {
            return Column(
              children: [
                if (state.isLoading)
                  const LinearProgressIndicator(minHeight: 4)
                else
                  const SizedBox(height: 4),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: _onRefresh,
                    child: ReorderableListView.builder(
                      onReorder: _onReorder,
                      itemCount: state.todoList.length,
                      itemBuilder: (context, index) => TodoListItem(
                        key: ValueKey(index),
                        onEdit: _onEdit,
                        onDelete: _onDelete,
                        onDoneChange: _onDoneChange,
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

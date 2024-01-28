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
  late final TodoListCubit cubit;

  @override
  void initState() {
    super.initState();

    cubit = BlocProvider.of<TodoListCubit>(context)..initTodoList();
  }

  void _onEdit(String id) {
    _handleNavigation(ScreenNames.createPage, {
      'id': id,
    });
  }

  void _onDelete(String id) {
    cubit.deleteTodo(id);
    // BlocProvider.of<TodoListBloc>(context).add(TodoListItemDeleted(id));
  }

  void _onDoneChange(String id) {
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

  Future<void> _onRefresh() async {
    await cubit.initTodoList();
  }

  void _handleNavigation(String routeName, Map<String, dynamic>? args) {
    AppNavigator.instance.push(routeName, args);
  }

  @override
  Widget build(BuildContext context) {
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
          builder: (context, state) {
            return Column(
              children: [
                state.isLoading
                    ? const LinearProgressIndicator(minHeight: 4)
                    : const SizedBox(height: 4),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: _onRefresh,
                    child: ListView.separated(
                      itemCount: state.todoList.length,
                      itemBuilder: (context, index) => TodoListItem(
                        onEdit: (id) => _onEdit(id),
                        onDelete: (id) => _onDelete(id),
                        onDoneChange: (id) => _onDoneChange(id),
                        todoItem: state.todoList[index],
                      ),
                      separatorBuilder: (context, index) => const Divider(
                        height: 1,
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/main.dart';
import 'package:todo/modules/todo/cubit/todo_list_cubit.dart';
import 'package:todo/pages/home_page/widgets/todo_list_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _onEdit(BuildContext context, String id) {
    _handleNavigation('/create', args: {
      id: id,
    });
  }

  void _onDelete(BuildContext context, String id) {
    BlocProvider.of<TodoListCubit>(context).deleteTodo(id);
    // BlocProvider.of<TodoListBloc>(context).add(TodoListItemDeleted(id));
  }

  void _handleNavigation(String routeName, {Object? args}) {
    navigatorKey.currentState?.pushNamed(routeName, arguments: args);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Список дел'),
        actions: [
          IconButton(
            onPressed: () => _handleNavigation('/create'),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: BlocBuilder<TodoListCubit, TodoListCubitState>(
        builder: (context, state) {
          return Column(
            children: [
              // const LinearProgressIndicator(),
              Expanded(
                child: ListView.separated(
                  itemCount: state.todoList.length,
                  itemBuilder: (context, index) => TodoListItem(
                    onEdit: (id) => _onEdit(context, id),
                    onDelete: (id) => _onDelete(context, id),
                    todoItem: state.todoList[index],
                  ),
                  separatorBuilder: (context, index) => const Divider(
                    height: 1,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

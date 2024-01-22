import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/modules/todo/bloc/todo_list_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Список дел'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/create');
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: BlocBuilder<TodoListBloc, TodoListState>(
        builder: (context, state) {
          return ListView.separated(
            itemCount: state.todoList.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(
                state.todoList[index].title,
              ),
            ),
            separatorBuilder: (context, index) => const Divider(
              height: 4,
            ),
          );
        },
      ),
    );
  }
}

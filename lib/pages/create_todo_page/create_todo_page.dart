import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/modules/todo/cubit/todo_list_cubit.dart';
import 'package:todo/modules/todo/models/todo_item.dart';
import 'package:todo/navigation/router.dart';

class CreateTodoPage extends StatefulWidget {
  const CreateTodoPage({super.key, this.currentTodoId});

  final String? currentTodoId;

  @override
  State<CreateTodoPage> createState() => _CreateTodoPageState();
}

class _CreateTodoPageState extends State<CreateTodoPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dateController = TextEditingController();

  late final TodoItem? _currentTodo;

  late final TodoListCubit cubit;

  void _onSave() {
    if (widget.currentTodoId == null) {
      _onTodoCreate();
    } else {
      _onTodoEdit();
    }
  }

  void _onTodoCreate() {
    cubit.addTodo(
      TodoItem(
        title: _titleController.text,
        description: _descriptionController.text,
        date: DateTime.tryParse(_dateController.text) ?? DateTime.now(),
      ),
    );

    _pop();
  }

  void _onTodoEdit() {
    cubit.editTodo(
      TodoItem(
        id: _currentTodo?.id,
        title: _titleController.text,
        description: _descriptionController.text,
        date: DateTime.tryParse(_dateController.text) ?? DateTime.now(),
        isDone: _currentTodo?.isDone,
      ),
    );

    _pop();
  }

  void _pop() {
    cubit.setCurrentTodo(null);
    AppNavigator.instance.pop();
  }

  @override
  void initState() {
    super.initState();

    // Isolate Example
    // int slowFib(int n) => n <= 1 ? 1 : slowFib(n - 1) + slowFib(n - 2);
    //
    // // Compute without blocking current isolate.
    // void fib40() async {
    //   var result = await Isolate.run(() => slowFib(40));
    //   print('Fib(40) = $result');
    // }
    //
    // fib40();

    cubit = context.read<TodoListCubit>();

    if (widget.currentTodoId != null) {
      cubit.getTodoById(widget.currentTodoId);

      _currentTodo = cubit.state.currentTodo;
      _titleController.text = _currentTodo?.title ?? '';
      _descriptionController.text = _currentTodo?.description ?? '';
      _dateController.text = _currentTodo?.date.toString() ?? '';
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Создать'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: TextField(
                        onTapOutside: (event) =>
                            FocusScope.of(context).unfocus(),
                        controller: _titleController,
                        decoration: const InputDecoration(
                          hintText: 'Название',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: TextField(
                        controller: _descriptionController,
                        decoration: const InputDecoration(
                          hintText: 'Описание',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: TextField(
                        controller: _dateController,
                        decoration: const InputDecoration(
                          hintText: 'Дата',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: _onSave,
                child: const Text('Сохранить'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

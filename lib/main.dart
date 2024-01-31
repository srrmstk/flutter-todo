import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo/modules/todo/bloc/todo_list_bloc.dart';
import 'package:todo/modules/todo/cubit/todo_list_cubit.dart';
import 'package:todo/modules/todo/data/todo_schema.dart';
import 'package:todo/navigation/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final isar = await Isar.open(
    [TodoSchema],
    directory: (await getApplicationDocumentsDirectory()).path,
  );

  GetIt.instance.registerSingleton(isar);

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TodoListCubit(),
        ),
        BlocProvider(
          create: (context) => TodoListBloc(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routerConfig: AppNavigator.instance.router,
      ),
    );
  }
}

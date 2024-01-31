import 'package:go_router/go_router.dart';
import 'package:todo/navigation/screen_names.dart';
import 'package:todo/pages/create_todo_page/create_todo_page.dart';
import 'package:todo/pages/home_page/home_page.dart';

class AppNavigator {
  static AppNavigator instance = AppNavigator();

  GoRouter get router => _router;

  final _router = GoRouter(
    initialLocation: ScreenNames.homePage,
    routes: [
      GoRoute(
        path: ScreenNames.homePage,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: ScreenNames.createPage,
        builder: (context, state) {
          final id = state.uri.queryParameters['id'];
          return CreateTodoPage(
            currentTodoId: id,
          );
        },
      ),
    ],
  );

  void push(String routeName, Map<String, dynamic>? args) {
    _router.push(Uri(path: routeName, queryParameters: args).toString());
  }

  void pop() {
    _router.pop();
  }
}

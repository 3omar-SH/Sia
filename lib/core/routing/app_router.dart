import 'package:go_router/go_router.dart';
import 'package:sia/feature/home/view/screens/add_task_screen.dart';
import 'package:sia/feature/home/view/screens/home_screen.dart';

abstract class AppRouter {
  static const String home = '/';
  static const String tasks = '/tasks';
  static const String analythis = '/analythis';
  static const String settings = '/settings';
  static const String addTask = '/addTask';


  static final router = GoRouter(
    initialLocation: home,
    routes: [
      GoRoute(
        path: home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: tasks,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: analythis,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: settings,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: addTask,
        builder: (context, state) => AddTaskScreen(args: state.extra as AddEditTaskArgs?),
      )
    ],
  );
}
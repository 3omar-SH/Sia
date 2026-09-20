import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repos/task_repos.dart';
import 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final TaskRepos taskRepos;

  TaskCubit({required this.taskRepos}) : super(TaskInitial());

  Future<void> loadTasksForDate(DateTime date) async {
    emit(TaskLoading());

    try {
      final tasks = await taskRepos.getDailyTasks(date);

      emit(TaskLoaded(tasks: tasks, selectedDate: date));
    } catch (e) {
      emit(TaskError(message: "error in fetch data: ${e.toString()}"));
    }
  }
}

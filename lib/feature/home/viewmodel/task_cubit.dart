import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sia/feature/home/data/model/task_model.dart';
import 'package:sia/feature/home/data/repos/task_data_source.dart';
import 'package:sia/feature/home/viewmodel/task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskDataSource taskDataSource = TaskDataSource();

  TaskCubit() : super(TaskStateInitial());

  Future<void> loadTasksForDate(DateTime date) async {
    emit(TaskStateLoading());
    try {
      final data = await taskDataSource.getTasksForDate(date);
      emit(TaskStateSuccess(tasks: data));
    } catch (e) {
      emit(TaskStateError(message: e.toString()));
    }
  }

  Future<void> saveTask(TaskModel task, DateTime currentDate) async {
    emit(TaskStateLoading());
    try {
      await taskDataSource.saveTask(task);

      final updatedTasks = await taskDataSource.getTasksForDate(currentDate);

      emit(TaskStateSuccess(tasks: updatedTasks));
    } catch (e) {
      emit(TaskStateError(message: e.toString()));
    }
  }

  Future<void> deleteTask(String taskId, DateTime currentDate) async {
    emit(TaskStateLoading());
    try {
      await taskDataSource.deleteTask(taskId);

      final updatedTasks = await taskDataSource.getTasksForDate(currentDate);

      emit(TaskStateSuccess(tasks: updatedTasks));
    } catch (e) {
      emit(TaskStateError(message: e.toString()));
    }
  }

  Future<void> toggleTaskCompletion(TaskModel task, DateTime currentDate) {
    final updated = task.copyWith(isCompleted: !task.isCompleted);
    return saveTask(updated, currentDate);
  }
}

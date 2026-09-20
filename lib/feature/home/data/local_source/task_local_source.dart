import 'package:hive/hive.dart';

import '../model/task_model.dart';

abstract class TaskLocalSource {
  Future<List<TaskModel>> getTaskForDate(DateTime date);
  Future<void> saveTask(TaskModel task);
  Future<void> deleteTask(String taskId);
}

class TaskLocalSourceImpl implements TaskLocalSource {
  final Box<TaskModel> taskBox;

  TaskLocalSourceImpl({required this.taskBox});

  @override
  Future<void> saveTask(TaskModel task) async {
    await taskBox.put(task.id, task);
  }

  @override
  Future<List<TaskModel>> getTaskForDate(DateTime date) async {
    final allTasks = taskBox.values.toList();
    return allTasks.where((task) {
      return task.startTime.year == date.year &&
          task.startTime.month == date.month &&
          task.startTime.day == date.day;
    }).toList();
  }

  @override
  Future<void> deleteTask(String taskId) async {
    await taskBox.delete(taskId);
  }
}

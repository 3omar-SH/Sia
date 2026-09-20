import '../entities/task_entity.dart';

abstract class TaskRepos {
  Future<List<TaskEntity>> getDailyTasks(DateTime date);
  Future<void> addTask(TaskEntity task);
  Future<void> deleteTask(String taskId);
}

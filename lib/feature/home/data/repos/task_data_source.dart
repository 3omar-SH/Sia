import 'package:hive/hive.dart';
import 'package:sia/feature/home/data/model/task_model.dart';

class TaskDataSource {
  static const String boxName = 'tasksBox';

  Future<List<TaskModel>> getTasksForDate(DateTime date) async {
    final box = await Hive.openBox<TaskModel>(boxName);
    final allTasks = box.values.toList();

    return allTasks.where((task) {
      return task.startTime.year == date.year &&
          task.startTime.month == date.month &&
          task.startTime.day == date.day;
    }).toList();
  }

  Future<void> saveTask(TaskModel task) async {
    final box = await Hive.openBox<TaskModel>(boxName);

    await box.put(task.id, task);
  }

  Future<void> deleteTask(String taskId) async {
    final box = await Hive.openBox<TaskModel>(boxName);

    await box.delete(taskId);
  }
}

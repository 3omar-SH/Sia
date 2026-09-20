import '../../domain/entities/task_entity.dart';
import '../../domain/repos/task_repos.dart';
import '../local_source/task_local_source.dart';
import '../model/task_model.dart';

class TaskReposImpl implements TaskRepos {
  final TaskLocalSource localSource;
  TaskReposImpl({required this.localSource});

  @override
  Future<List<TaskEntity>> getDailyTasks(DateTime date) async {
    final models = await localSource.getTaskForDate(date);

    return models
        .map(
          (model) => TaskEntity(
            id: model.id,
            title: model.title,
            subtitle: model.subtitle,
            locationOrTag: model.locationOrTag,
            startTime: model.startTime,
            endTime: model.endTime,
            category: model.category,
          ),
        )
        .toList();
  }

  @override
  Future<void> addTask(TaskEntity task) async {
    final model = TaskModel(
      id: task.id,
      title: task.title,
      subtitle: task.subtitle,
      startTime: task.startTime,
      endTime: task.endTime,
      category: task.category,
    );
    await localSource.saveTask(model);
  }

  @override
  Future<void> deleteTask(String taskId) async {
    await localSource.deleteTask(taskId);
  }
}

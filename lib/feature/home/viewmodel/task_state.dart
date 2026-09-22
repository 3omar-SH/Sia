import 'package:sia/feature/home/data/model/task_model.dart';

abstract class TaskState {}

class TaskStateInitial extends TaskState {}

class TaskStateLoading extends TaskState {}

class TaskStateSuccess extends TaskState {
  final List<TaskModel> tasks;

  TaskStateSuccess({required this.tasks}); 
}

class TaskStateError extends TaskState {
  final String message;

  TaskStateError({required this.message}); 
}
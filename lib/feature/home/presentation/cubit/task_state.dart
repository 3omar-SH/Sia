import '../../domain/entities/task_entity.dart';

abstract class TaskState {}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final List<TaskEntity> tasks;
  final DateTime selectedDate;

  TaskLoaded({required this.tasks, required this.selectedDate});
}

class TaskError extends TaskState {
  final String message;
  TaskError({required this.message});
}

import 'package:hive/hive.dart';

class TaskModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String subtitle;

  @HiveField(3)
  final String? locationOrTag;

  @HiveField(4)
  final DateTime startTime;

  @HiveField(5)
  final DateTime endTime;

  @HiveField(6)
  final String category;

  TaskModel({
    required this.id,
    required this.title,
    required this.subtitle,
    this.locationOrTag,
    required this.startTime,
    required this.endTime,
    required this.category,
  });
}

class TaskEntity {
  final String id;

  final String title;

  final String subtitle;

  final String? locationOrTag;

  final DateTime startTime;

  final DateTime endTime;

  final String category;

  TaskEntity({
    required this.id,
    required this.title,
    required this.subtitle,
    this.locationOrTag,
    required this.startTime,
    required this.endTime,
    required this.category,
  });
}

import 'package:hive/hive.dart';

class TaskModel extends HiveObject {
  final String id;
  final String title;
  final String subtitle;
  final String? locationOrTag;
  final DateTime startTime;
  final DateTime endTime;
  final String category;
  final bool isCompleted;

  TaskModel({
    required this.id,
    required this.title,
    required this.subtitle,
    this.locationOrTag,
    required this.startTime,
    required this.endTime,
    required this.category,
    this.isCompleted = false,
  });

  TaskModel copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? locationOrTag,
    DateTime? startTime,
    DateTime? endTime,
    String? category,
    bool? isCompleted,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      locationOrTag: locationOrTag ?? this.locationOrTag,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      category: category ?? this.category,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}

class TaskModelAdapter extends TypeAdapter<TaskModel> {
  @override
  final int typeId = 0;

  @override
  TaskModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskModel(
      id: fields[0] as String,
      title: fields[1] as String,
      subtitle: fields[2] as String,
      locationOrTag: fields[3] as String?,
      startTime: fields[4] as DateTime,
      endTime: fields[5] as DateTime,
      category: fields[6] as String,
      isCompleted: fields[7] as bool? ?? false,
    );
  }

  @override
  void write(BinaryWriter writer, TaskModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.subtitle)
      ..writeByte(3)
      ..write(obj.locationOrTag)
      ..writeByte(4)
      ..write(obj.startTime)
      ..writeByte(5)
      ..write(obj.endTime)
      ..writeByte(6)
      ..write(obj.category)
      ..writeByte(7)
      ..write(obj.isCompleted);
  }
}

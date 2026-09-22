import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sia/core/constants/app_colors.dart';
import 'package:sia/feature/home/data/model/task_model.dart';
import 'package:sia/feature/home/viewmodel/task_cubit.dart';

class AddEditTaskArgs {
  final TaskModel? task;
  final DateTime initialDate;

  const AddEditTaskArgs({this.task, required this.initialDate});
}

class AddTaskScreen extends StatefulWidget {
  final AddEditTaskArgs? args;

  const AddTaskScreen({super.key, this.args});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _subtitleController;
  late final TextEditingController _locationController;

  late DateTime _date;
  late TimeOfDay _startTime;
  late TimeOfDay _endTime;
  late String _category;

  static const List<String> _categories = ['دراسي', 'تنظيم وقت', 'كورسات', 'عمل'];

  bool get _isEditing => widget.args?.task != null;

  @override
  void initState() {
    super.initState();
    final task = widget.args?.task;
    final initialDate = widget.args?.initialDate ?? DateTime.now();

    _titleController = TextEditingController(text: task?.title ?? '');
    _subtitleController = TextEditingController(text: task?.subtitle ?? '');
    _locationController = TextEditingController(text: task?.locationOrTag ?? '');

    final baseDate = task?.startTime ?? initialDate;
    _date = DateTime(baseDate.year, baseDate.month, baseDate.day);
    _startTime = TimeOfDay.fromDateTime(task?.startTime ?? DateTime.now());
    _endTime = TimeOfDay.fromDateTime(
      task?.endTime ?? DateTime.now().add(const Duration(hours: 1)),
    );
    _category = _categories.contains(task?.category) ? task!.category : _categories.first;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _subtitleController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 730)),
    );
    if (picked != null) setState(() => _date = picked);
  }

  Future<void> _pickTime({required bool isStart}) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: isStart ? _startTime : _endTime,
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startTime = picked;
        } else {
          _endTime = picked;
        }
      });
    }
  }

  DateTime _combine(DateTime date, TimeOfDay time) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    final startDateTime = _combine(_date, _startTime);
    final endDateTime = _combine(_date, _endTime);

    if (!endDateTime.isAfter(startDateTime)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('وقت النهاية يجب أن يكون بعد وقت البداية'),
          backgroundColor: AppColors.danger,
        ),
      );
      return;
    }

    final existing = widget.args?.task;
    final task = TaskModel(
      id: existing?.id ?? DateTime.now().microsecondsSinceEpoch.toString(),
      title: _titleController.text.trim(),
      subtitle: _subtitleController.text.trim(),
      locationOrTag: _locationController.text.trim().isEmpty
          ? null
          : _locationController.text.trim(),
      startTime: startDateTime,
      endTime: endDateTime,
      category: _category,
      isCompleted: existing?.isCompleted ?? false,
    );

    context.read<TaskCubit>().saveTask(task, _date);
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'تعديل المهمة' : 'إضافة مهمة جديدة'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'عنوان المهمة',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => (value == null || value.trim().isEmpty)
                      ? 'العنوان مطلوب'
                      : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _subtitleController,
                  decoration: const InputDecoration(
                    labelText: 'الوصف',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _locationController,
                  decoration: const InputDecoration(
                    labelText: 'الموقع (اختياري)',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _category,
                  decoration: const InputDecoration(
                    labelText: 'التصنيف',
                    border: OutlineInputBorder(),
                  ),
                  items: _categories
                      .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) setState(() => _category = value);
                  },
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: _pickDate,
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      labelText: 'التاريخ',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.calendar_today_outlined),
                    ),
                    child: Text(
                      '${_date.year}-${_date.month.toString().padLeft(2, '0')}-${_date.day.toString().padLeft(2, '0')}',
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () => _pickTime(isStart: true),
                        child: InputDecorator(
                          decoration: const InputDecoration(
                            labelText: 'وقت البداية',
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.access_time),
                          ),
                          child: Text(_startTime.format(context)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: InkWell(
                        onTap: () => _pickTime(isStart: false),
                        child: InputDecorator(
                          decoration: const InputDecoration(
                            labelText: 'وقت النهاية',
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.access_time),
                          ),
                          child: Text(_endTime.format(context)),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _save,
                    style: ElevatedButton.styleFrom(backgroundColor: theme.primaryColor),
                    child: Text(
                      _isEditing ? 'تحديث المهمة' : 'حفظ المهمة',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

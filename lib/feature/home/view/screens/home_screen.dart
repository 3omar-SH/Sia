import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sia/core/constants/app_colors.dart';
import 'package:sia/core/routing/app_router.dart';
import 'package:sia/feature/home/data/model/task_model.dart';
import 'package:sia/feature/home/view/screens/add_task_screen.dart';
import 'package:sia/feature/home/view/widgets/category_card.dart';
import 'package:sia/feature/home/view/widgets/date_selector.dart';
import 'package:sia/feature/home/view/widgets/task_item.dart';
import 'package:sia/feature/home/viewmodel/task_cubit.dart';
import 'package:sia/feature/home/viewmodel/task_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    context.read<TaskCubit>().loadTasksForDate(_selectedDate);
  }

  void _selectDate(DateTime date) {
    setState(() => _selectedDate = date);
    context.read<TaskCubit>().loadTasksForDate(date);
  }

  Future<void> _pickAnyDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 730)),
    );
    if (picked != null) _selectDate(picked);
  }

  Future<void> _openAddEditTask({TaskModel? task}) async {
    final saved = await context.push<bool>(
      AppRouter.addTask,
      extra: AddEditTaskArgs(task: task, initialDate: _selectedDate),
    );
    if (saved == true && mounted) {
      context.read<TaskCubit>().loadTasksForDate(_selectedDate);
    }
  }

  String _taskCountLabel(int count) {
    if (count == 0) return 'لا توجد مهام';
    if (count == 1) return 'مهمة واحدة';
    if (count == 2) return 'مهمتان';
    if (count >= 3 && count <= 10) return '$count مهام';
    return '$count مهمة';
  }

  Widget _circleIconButton({required IconData icon, required VoidCallback onTap}) {
    final theme = Theme.of(context);
    return Material(
      color: theme.cardColor,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Container(
          width: 44,
          height: 44,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: theme.dividerColor),
          ),
          child: Icon(icon, color: theme.iconTheme.color, size: 20),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      key: _scaffoldKey,
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openAddEditTask(),
        backgroundColor: theme.primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index != 0) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('هذا القسم قيد التطوير')),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.checklist_outlined),
            activeIcon: Icon(Icons.checklist),
            label: 'المهام',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_outlined),
            activeIcon: Icon(Icons.bar_chart),
            label: 'الإحصائيات',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'الملف الشخصي',
          ),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => context.read<TaskCubit>().loadTasksForDate(_selectedDate),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _circleIconButton(icon: Icons.notifications_outlined, onTap: () {}),
                      _circleIconButton(
                        icon: Icons.menu,
                        onTap: () => _scaffoldKey.currentState?.openEndDrawer(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text("مرحبًا بك في Sia 👋", style: theme.textTheme.headlineLarge),
                  const SizedBox(height: 8),
                  Text(
                    "خطط يومك، نظم وقتك، وحقق أهدافك",
                    style: theme.textTheme.bodySmall,
                  ),
                  const SizedBox(height: 24),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        CategoryCard(
                          title: "دراسي",
                          subtitle: "جدول المواد والمذاكرة",
                          icon: Icons.school_outlined,
                          style: CategoryStyle.of(
                            context,
                            CategoryStyle.study,
                            CategoryStyle.studyDark,
                          ),
                        ),
                        const SizedBox(width: 12),
                        CategoryCard(
                          title: "تنظيم وقت",
                          subtitle: "خطط يومك بكفاءة",
                          icon: Icons.schedule,
                          style: CategoryStyle.of(
                            context,
                            CategoryStyle.time,
                            CategoryStyle.timeDark,
                          ),
                        ),
                        const SizedBox(width: 12),
                        CategoryCard(
                          title: "كورسات",
                          subtitle: "متابعة الكورسات والمهارات",
                          icon: Icons.menu_book_outlined,
                          style: CategoryStyle.of(
                            context,
                            CategoryStyle.courses,
                            CategoryStyle.coursesDark,
                          ),
                        ),
                        const SizedBox(width: 12),
                        CategoryCard(
                          title: "عمل",
                          subtitle: "تنظيم المهام والمشاريع",
                          icon: Icons.work_outline,
                          style: CategoryStyle.of(
                            context,
                            CategoryStyle.work,
                            CategoryStyle.workDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  DateSelector(
                    selectedDate: _selectedDate,
                    onDateSelected: _selectDate,
                    onHeaderTap: _pickAnyDate,
                  ),

                  const SizedBox(height: 24),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('جدول اليوم', style: theme.textTheme.titleMedium),
                      Row(
                        children: [
                          Text('الكل', style: theme.textTheme.bodySmall),
                          const SizedBox(width: 4),
                          Icon(Icons.filter_list, size: 18, color: theme.iconTheme.color),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  BlocConsumer<TaskCubit, TaskState>(
                    listener: (context, state) {
                      if (state is TaskStateError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.message),
                            backgroundColor: AppColors.danger,
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is TaskStateLoading || state is TaskStateInitial) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 40),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      } else if (state is TaskStateSuccess) {
                        if (state.tasks.isEmpty) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(32.0),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.event_available_outlined,
                                    size: 48,
                                    color: theme.textTheme.bodySmall?.color,
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    "لا توجد مهام في هذا اليوم",
                                    style: theme.textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                        final tasks = [...state.tasks]
                          ..sort((a, b) => a.startTime.compareTo(b.startTime));
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _taskCountLabel(tasks.length),
                              style: theme.textTheme.bodySmall,
                            ),
                            const SizedBox(height: 8),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: tasks.length,
                              itemBuilder: (context, index) {
                                final task = tasks[index];
                                return TaskItem(
                                  task: task,
                                  onTap: () => _openAddEditTask(task: task),
                                  onDelete: () => context
                                      .read<TaskCubit>()
                                      .deleteTask(task.id, _selectedDate),
                                  onToggleComplete: () => context
                                      .read<TaskCubit>()
                                      .toggleTaskCompletion(task, _selectedDate),
                                );
                              },
                            ),
                          ],
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

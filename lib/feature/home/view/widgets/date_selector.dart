import 'package:flutter/material.dart';
import 'day_item.dart';

class DateSelector extends StatelessWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;
  final VoidCallback? onHeaderTap;

  const DateSelector({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
    this.onHeaderTap,
  });

  static const List<String> _arabicMonths = [
    'يناير',
    'فبراير',
    'مارس',
    'أبريل',
    'مايو',
    'يونيو',
    'يوليو',
    'أغسطس',
    'سبتمبر',
    'أكتوبر',
    'نوفمبر',
    'ديسمبر',
  ];

  static const List<String> _arabicDays = [
    'الأحد',
    'الاثنين',
    'الثلاثاء',
    'الأربعاء',
    'الخميس',
    'الجمعة',
    'السبت',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final DateTime now = DateTime.now();
    final int daysSinceSunday = now.weekday % 7;
    final DateTime startOfWeek = now.subtract(Duration(days: daysSinceSunday));

    final List<DateTime> weekDates = List.generate(
      7,
      (index) => startOfWeek.add(Duration(days: index)),
    );

    final String currentMonthYear =
        "${_arabicMonths[selectedDate.month - 1]} ${selectedDate.year}";

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  size: 18,
                  color: theme.primaryColor,
                ),
                const SizedBox(width: 8),
                Text(
                  'هذا الأسبوع',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.primaryColor,
                  ),
                ),
              ],
            ),
            InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: onHeaderTap,
              child: Row(
                children: [
                  Text(currentMonthYear, style: theme.textTheme.titleMedium),
                  const Icon(Icons.keyboard_arrow_down),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: weekDates.map((date) {
              return DayItem(
                date: date,
                dayLabel: _arabicDays[date.weekday % 7],
                isSelected:
                    date.year == selectedDate.year &&
                    date.month == selectedDate.month &&
                    date.day == selectedDate.day,
                onTap: () => onDateSelected(date),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

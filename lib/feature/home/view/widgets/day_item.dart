import 'package:flutter/material.dart';

class DayItem extends StatelessWidget {
  final DateTime date;
  final String dayLabel;
  final bool isSelected;
  final VoidCallback onTap;

  const DayItem({
    super.key,
    required this.date,
    required this.dayLabel,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? theme.primaryColor : theme.cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? theme.primaryColor : theme.dividerColor,
          ),
        ),
        child: Column(
          children: [
            Text(
              dayLabel,
              style: theme.textTheme.bodySmall?.copyWith(
                color: isSelected ? Colors.white : theme.textTheme.bodySmall?.color,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              date.day.toString(),
              style: theme.textTheme.titleMedium?.copyWith(
                color: isSelected ? Colors.white : theme.textTheme.titleMedium?.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

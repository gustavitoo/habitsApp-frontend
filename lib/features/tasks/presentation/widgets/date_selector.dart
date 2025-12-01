import 'package:flutter/material.dart';
import 'package:habits_app/core/utils/date_utils.dart';
import 'package:habits_app/features/tasks/domain/task.dart';
import 'package:intl/intl.dart';

class DateSelector extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;
  final TaskType filter;

  const DateSelector({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
    required this.filter,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 30,
        itemBuilder: (context, index) {
          DateTime date;
          String topText;
          String bottomText;
          bool isSelected;

          if (filter == TaskType.DAILY) {
            date = DateTime.now().add(Duration(days: index));
            isSelected = DateUtilsHelper.isSameDay(date, selectedDate);
            topText = DateFormat('EEE').format(date).toUpperCase();
            bottomText = date.day.toString();
          } else if (filter == TaskType.WEEKLY) {
            // Start from current week
            final now = DateTime.now();
            final currentWeekStart = now.subtract(
              Duration(days: now.weekday - 1),
            );
            date = currentWeekStart.add(Duration(days: index * 7));
            // Check if selectedDate falls within this week
            final diff = selectedDate.difference(date).inDays;
            isSelected = diff >= 0 && diff < 7;

            final endOfWeek = date.add(const Duration(days: 6));
            topText = 'WEEK ${index + 1}';
            bottomText =
                '${DateFormat('d MMM').format(date)} - ${DateFormat('d MMM').format(endOfWeek)}';
          } else {
            // MONTHLY
            final now = DateTime.now();
            date = DateTime(now.year, now.month + index, 1);
            isSelected =
                date.year == selectedDate.year &&
                date.month == selectedDate.month;
            topText = DateFormat('yyyy').format(date);
            bottomText = DateFormat('MMM').format(date).toUpperCase();
          }

          return GestureDetector(
            onTap: () => onDateSelected(date),
            child: Container(
              width: filter == TaskType.WEEKLY ? 140 : 60,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  if (!isSelected)
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    topText,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.white : Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    bottomText,
                    style: TextStyle(
                      fontSize: filter == TaskType.WEEKLY ? 12 : 20,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

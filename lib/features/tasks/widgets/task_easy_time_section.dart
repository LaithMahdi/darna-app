import 'dart:developer';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../view_models/task_view_model.dart';
import 'task_time_line.dart';
import 'task_time_title.dart';

class TaskEasyTimeSection extends ConsumerWidget {
  const TaskEasyTimeSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(selectedTaskDateProvider);
    final focusedDate = selectedDate ?? DateTime.now();
    Duration duration = Duration(days: 30);

    return EasyDateTimeLinePicker.itemBuilder(
      focusedDate: focusedDate,
      firstDate: DateTime.now().subtract(duration),
      lastDate: DateTime.now().add(duration),
      daySeparatorPadding: 10,
      itemExtent: 75,
      itemBuilder: (context, date, isSelected, isDisabled, isToday, onTap) =>
          TaskTimeLine(date: date, isSelected: isSelected, onTap: onTap),
      onDateChange: (date) {
        final normalizedDate = DateTime(date.year, date.month, date.day);
        log('TaskEasyTimeSection: Date selected=$normalizedDate');
        ref.read(selectedTaskDateProvider.notifier).state = normalizedDate;
      },
      timelineOptions: TimelineOptions(height: 90),
      headerOptions: HeaderOptions(
        headerBuilder: (context, date, onTap) {
          return TaskTimeTitle(date: date, onTap: onTap);
        },
      ),
    );
  }
}

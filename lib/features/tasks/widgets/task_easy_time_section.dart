import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'task_time_line.dart';
import 'task_time_title.dart';

class TaskEasyTimeSection extends StatelessWidget {
  const TaskEasyTimeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return EasyDateTimeLinePicker.itemBuilder(
      focusedDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 30)),
      daySeparatorPadding: 10,
      itemExtent: 64.0,
      itemBuilder: (context, date, isSelected, isDisabled, isToday, onTap) =>
          TaskTimeLine(date: date, isSelected: isSelected, onTap: () {}),
      onDateChange: (date) {},
      timelineOptions: TimelineOptions(height: 90),
      headerOptions: HeaderOptions(
        headerBuilder: (context, date, onTap) {
          return TaskTimeTitle(date: date, onTap: onTap);
        },
      ),
    );
  }
}

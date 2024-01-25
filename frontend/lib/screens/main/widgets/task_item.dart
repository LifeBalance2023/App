import 'package:flutter/material.dart';
import 'package:frontend/utils/date_time_formatter.dart';

class TaskItem extends StatelessWidget {
  final String taskName;
  final bool isDone;
  final DateTime date;
  final VoidCallback onCheckboxClicked;

  const TaskItem({
    Key? key,
    required this.taskName,
    required this.isDone,
    required this.date,
    required this.onCheckboxClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    taskName,
                    style: TextStyle(
                      decoration: isDone ? TextDecoration.lineThrough : null,
                        fontFamily: 'JejuGothic',
                        fontSize: 18.0
                    ),
                  ),
                  Text('Due date: ${DateTimeFormatter.toStringDate(date)}',
                    style: TextStyle(
                      decoration: isDone ? TextDecoration.lineThrough : null,
                      fontFamily: 'JejuGothic',
                      fontSize: 10.0
                  ),),
                ],
              ),
            ),
            Checkbox(
              value: isDone,
              onChanged: (bool? newValue) {
                onCheckboxClicked();
              },
            ),
          ],
        ),
      ),
    );
  }
}

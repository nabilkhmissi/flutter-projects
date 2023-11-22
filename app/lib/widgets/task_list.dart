import 'package:app/models/task.dart';
import 'package:app/widgets/task_item.dart';
import 'package:flutter/material.dart';

class TaskListWidget extends StatelessWidget {
  final List<Task> tasks;

  TaskListWidget({required this.tasks});

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: tasks
            .map(
              (e) => TaskItem(task: e),
            )
            .toList());
  }
}

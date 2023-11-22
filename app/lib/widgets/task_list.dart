import 'package:app/data/task_data.dart';
import 'package:app/widgets/task_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
        /*  builder: (context, taskData, child) => ListView.builder(
        itemBuilder: (context, index) => TaskItem(
          task: taskData.tasks[index],
        ),
        itemCount: taskData.tasks.length,
      ), */
        builder: (context, taskData, child) => ReorderableListView.builder(
              itemBuilder: (context, index) => Card(
                key: ValueKey(index),
                child: TaskItem(
                  task: taskData.tasks[index],
                ),
              ),
              itemCount: taskData.tasks.length,
              onReorder: (oldIndex, newIndex) {},
            ));
  }
}

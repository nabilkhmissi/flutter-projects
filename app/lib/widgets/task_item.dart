import 'package:app/data/task_data.dart';
import 'package:app/models/task.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskItem extends StatelessWidget {
  final Task task;

  TaskItem({required this.task});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: () {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Text("arning"),
            content: Text("Do you want to delete task ?"),
            actions: [
              TextButton(
                onPressed: () {
                  Provider.of<TaskData>(context, listen: false)
                      .deleteTask(task.id);
                  Navigator.pop(context);
                },
                child: Text('YES'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('NO'),
              )
            ],
          ),
        );
      },
      title: Text(
        task.title,
        style: TextStyle(
            decoration: task.isDone ? TextDecoration.lineThrough : null),
      ),
      trailing: Checkbox(
        value: task.isDone,
        activeColor: Colors.teal[400],
        onChanged: (value) {
          Provider.of<TaskData>(context, listen: false).completeTask(task.id);
        },
      ),
    );
  }
}

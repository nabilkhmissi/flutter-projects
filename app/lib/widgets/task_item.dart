import 'package:app/models/task.dart';
import 'package:app/services/task_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';

class TaskItem extends StatefulWidget {
  final Task task;

  TaskItem({required this.task}) {}

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  TaskService task_service = GetIt.I<TaskService>();
  bool isDone = false;

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
                onPressed: () {},
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
        widget.task.title,
        style: TextStyle(
            decoration: widget.task.isDone ? TextDecoration.lineThrough : null),
      ),
      trailing: Checkbox(
        value: widget.task.isDone,
        activeColor: Colors.teal[400],
        onChanged: (value) async {
          await task_service.markTaskAsDone(widget.task.id);
          setState(() {
            widget.task.isDone = !widget.task.isDone;
          });
        },
      ),
    );
  }
}

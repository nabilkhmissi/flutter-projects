import 'package:app/models/add_task_request.dart';
import 'package:app/services/shared_preferences.dart';
import 'package:app/services/task_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class AddTaskScreen extends StatelessWidget {
  TaskService task_service = GetIt.I<TaskService>();
  SharedPrefernces shared_prefs = GetIt.I<SharedPrefernces>();

  TextEditingController _title = TextEditingController();

  _addTask(BuildContext ctx) async {
    final user_id = await shared_prefs.getLoggedUserIDFromPrefs();
    await task_service
        .addtask(AddTaskRequest(userId: user_id!, title: _title.text));
    Navigator.pop(ctx);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Create New Task',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.indigo[400],
            ),
          ),
          TextField(
            controller: _title,
            autofocus: true,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () => _addTask(context),
            child: Text(
              'Create',
              style: TextStyle(fontSize: 15),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal[400],
            ),
          )
        ],
      ),
    );
  }
}

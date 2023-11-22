import 'package:app/models/task.dart';
import 'package:app/screens/add_task.dart';
import 'package:app/services/auth_service.dart';
import 'package:app/services/shared_preferences.dart';
import 'package:app/services/task_service.dart';
import 'package:app/widgets/custom_drawer.dart';
import 'package:app/widgets/task_list.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class TasksScreen extends StatefulWidget {
  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  TaskService taskService = GetIt.I<TaskService>();
  SharedPrefernces shared_prefs = GetIt.I<SharedPrefernces>();

  List<Task> user_tasks = [];

  @override
  void initState() {
    super.initState();
    fetchTasks();
  }

  fetchTasks() async {
    print("============== [ TASKS SCREEN ] FETCH TASKS ==============");
    final id = await shared_prefs.getLoggedUserIDFromPrefs();
    final response = await taskService.getTasksByUserId(id!);
    setState(() {
      user_tasks = response.data;
    });
  }

  @override
  Widget build(BuildContext context) {
    AuthService service = GetIt.I<AuthService>();
    return Scaffold(
      drawer: CustomDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => AddTaskScreen(),
          ).then((value) {
            fetchTasks();
          });
        },
        child: Icon(
          Icons.add,
        ),
        backgroundColor: Colors.indigo[400],
      ),
      body: Container(
        padding: const EdgeInsets.only(
          top: 60,
          left: 10,
          right: 10,
          bottom: 45,
        ),
        color: Colors.teal[400],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.playlist_add_check,
                      size: 40,
                      color: Colors.white,
                    ),
                    Text(
                      'ToDoDay',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: TextButton(
                    child: Icon(Icons.person),
                    onPressed: () {},
                  ),
                )
              ],
            ),
            Row(
              children: [
                Text(
                  'All - ${user_tasks.length}',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                /*  SizedBox(width: 10),
                Text(
                  '| Done - ${user_tasks}',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  '| Undone - ${user_tasks}',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ), */
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: user_tasks.length > 0
                    ? TaskListWidget(
                        tasks: user_tasks,
                      )
                    : const Padding(
                        padding: EdgeInsets.all(10),
                        child: Center(
                          child: Text(
                            "There is nothing to show here !",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

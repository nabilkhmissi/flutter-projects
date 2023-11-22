import 'package:app/data/task_data.dart';
import 'package:app/screens/add_task.dart';
import 'package:app/services/auth_service.dart';
import 'package:app/widgets/task_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';

class TasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthService service = GetIt.I<AuthService>();
    return Consumer<TaskData>(
      builder: (context, taskData, child) => Scaffold(
        drawer: Drawer(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "ToDoDay",
                        style: TextStyle(
                          color: Colors.teal[400],
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Text('user'),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.teal[400],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(children: [
                    ListTile(
                      leading: Icon(Icons.home),
                      title: Text('Home'),
                    ),
                    ListTile(
                      leading: Icon(Icons.menu),
                      title: Text('Todos'),
                    ),
                  ]),
                ),
              )
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => AddTaskScreen(),
            );
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
              Row(
                children: [
                  Text(
                    'All - ${taskData.tasks.length}',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    '| Done - ${taskData.countCheckedTasks()}',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    '| Undone - ${taskData.countUncheckedTasks()}',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
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
                  child: taskData.tasks.length > 0
                      ? TaskListWidget()
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
      ),
    );
  }
}

import 'package:app/data/task_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddTaskScreen extends StatelessWidget {
  List<String> items = [
    "category 1",
    "category 2",
    "category 3",
    "category 4",
    "category 5"
  ];
  TextEditingController _title = TextEditingController();

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
            onPressed: () {
              Provider.of<TaskData>(context, listen: false)
                  .addTask(_title.text);
              Navigator.pop(context);
            },
            child: Text(
              'Create',
              style: TextStyle(fontSize: 15),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal[400],
            ),
          ),
          Center(
            child: DropdownButton<String>(
                value: items[0],
                items: items
                    .map((item) => DropdownMenuItem(
                          child: Text(item),
                          value: item,
                        ))
                    .toList(),
                onChanged: (item) {
                  print(item);
                }),
          )
        ],
      ),
    );
  }
}

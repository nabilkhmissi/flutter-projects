import 'dart:convert';

import 'package:app/models/task.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskData extends ChangeNotifier {
  final dataKey = 'tododay';
  List<Task> tasks = [];

  TaskData() {
    initTaskData();
  }

  void initTaskData() async {
    print("========== INITIALIZE TASKS ============");
    tasks = await getTasksFromPrefs();
  }

  Future<void> saveTasksToPrefs(List<Task> task) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(dataKey, json.encode(listToMapList(tasks)));
  }

  Future<List<Task>> getTasksFromPrefs() async {
    List<Task> taskData = [];
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(dataKey);
    if (jsonString == null) {
      taskData = [];
    } else {
      // Convert JSON string to Map
      final map = json.decode(jsonString);
      // Create a Task object from Map
      for (var item in map) {
        print(item);
        taskData.add(Task.fromMap(item));
      }
    }
    return taskData;
  }

  // Convert List<Task> to List<Map<String, dynamic>>
  static List<Map<String, dynamic>> listToMapList(List<Task> tasks) {
    return tasks.map((task) => task.toMap()).toList();
  }

  int countCheckedTasks() {
    return tasks.where((task) => task.isDone).length;
  }

  int countUncheckedTasks() {
    return tasks.where((task) => !task.isDone).length;
  }

  addTask(String title) {
    tasks.add(Task(id: tasks.length + 1, title: title));
    saveTasksToPrefs(tasks);
    notifyListeners();
  }

  completeTask(int id) {
    Task task = tasks.firstWhere((element) => element.id == id);
    task.doneChange();
    saveTasksToPrefs(tasks);
    notifyListeners();
  }

  deleteTask(int id) {
    tasks.removeWhere((element) => element.id == id);
    saveTasksToPrefs(tasks);
    notifyListeners();
  }
}

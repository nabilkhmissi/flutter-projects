import 'dart:convert';

class Task {
  final int id;
  final String title;
  bool isDone;

  Task({required this.id, required this.title, this.isDone = false});

  void doneChange() {
    isDone = !isDone;
  }

  // Convert Task to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'isDone': isDone,
    };
  }

  // Create a Task object from a Map
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      isDone: map['isDone'] ?? false,
    );
  }
  // Convert Task to JSON string
  String toJson() => json.encode(toMap());
}

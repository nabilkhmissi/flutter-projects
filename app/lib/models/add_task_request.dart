class AddTaskRequest {
  int userId;
  String title;
  AddTaskRequest({required this.userId, required this.title});

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "title": title,
    };
  }
}

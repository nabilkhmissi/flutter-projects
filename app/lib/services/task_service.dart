import 'dart:convert';

import 'package:app/interceptors/dio_interceptor.dart';
import 'package:app/models/add_task_request.dart';
import 'package:app/models/auth_response.dart';
import 'package:app/models/task.dart';
import 'package:app/models/user.dart';
import 'package:app/services/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

const ip = "172.19.14.50";
const port = 3000;
const apiUrl = 'http://$ip:$port';

class TaskService {
  late final Dio _dio;
  final headers = {'Content-Type': 'application/json'};

  TaskService() {
    _dio = Dio();
    _dio.interceptors.add(DioInterceptor());
  }

  Future<ApiResponse> getTasksByUserId(int user_id) async {
    print("=============== [ Task service ] GETTING TASKS =============");
    final response = await _dio.get('$apiUrl/tasks/user/$user_id');
    final jsonData = response.data['data'];
    List<Task> tasks = [];
    for (var item in jsonData) {
      tasks.add(Task.fromMap(item));
    }
    return ApiResponse(message: response.data['message'], data: tasks);
  }

  Future<ApiResponse> markTaskAsDone(int task_id) async {
    print("=============== [ Task service ] MARK TASK AS DONE =============");
    final response = await _dio.get('$apiUrl/tasks/$task_id/done');
    return ApiResponse(message: response.data['message']);
  }

  Future<ApiResponse> addtask(AddTaskRequest request) async {
    print("=============== [ Task service ] ADD TASK =============");
    final response = await _dio.post(
      '$apiUrl/tasks',
      data: request,
      options: Options(headers: headers),
    );
    return ApiResponse(message: response.data['message']);
  }
}

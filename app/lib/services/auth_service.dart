import 'dart:convert';

import 'package:app/interceptors/dio_interceptor.dart';
import 'package:app/models/auth_request.dart';
import 'package:app/models/auth_response.dart';
import 'package:app/models/register_request.dart';
import 'package:app/models/user.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

const ip = "172.19.14.50";
const port = 3000;
const apiUrl = 'http://$ip:$port';

class AuthService {
  late final Dio _dio;
  final headers = {'Content-Type': 'application/json'};

  AuthService() {
    _dio = Dio();
    _dio.interceptors.add(DioInterceptor());
  }

  final LOGGED_USER_KEY = "tododay_user";

  Future<void> saveUserToPrefs(User user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(LOGGED_USER_KEY, json.encode(user.toMap()));
  }

  Future<User?> getUserFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(LOGGED_USER_KEY);
    if (jsonString == null) {
      return null;
    }
    return User.fromMap(json.decode(jsonString));
  }

  Future<ApiResponse> login(AuthRequest credentials) async {
    try {
      final response = await _dio.post(
        '$apiUrl/auth/login',
        data: credentials,
        options: Options(headers: headers),
      );
      final jsonData = User.fromJson(response.data['data']);
      return ApiResponse(message: response.data['message'], data: jsonData);
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  Future<ApiResponse> register(RegisterRequest request) async {
    try {
      final response = await _dio.post(
        '$apiUrl/auth/register',
        data: request,
        options: Options(headers: headers),
      );
      final jsonData = User.fromJson(response.data['data']);
      return ApiResponse(message: response.data['message'], data: jsonData);
    } on DioException catch (e) {
      print(e.response?.data);
      print("================== EXCEPTION RAISED =====================");
      return _handleError(e);
    }
  }

  _handleError(DioException e) {
    throw Exception(e.response?.data['message']);
  }
}

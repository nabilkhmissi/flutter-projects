import 'dart:convert';

import 'package:app/interceptors/dio_interceptor.dart';
import 'package:app/models/auth_request.dart';
import 'package:app/models/auth_response.dart';
import 'package:app/models/register_request.dart';
import 'package:app/models/user.dart';
import 'package:app/services/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

const ip = "172.19.14.50";
const port = 3000;
const apiUrl = 'http://$ip:$port';

class AuthService {
  late final Dio _dio;
  final headers = {'Content-Type': 'application/json'};

  SharedPrefernces shared_prefs = GetIt.I<SharedPrefernces>();

  AuthService() {
    _dio = Dio();
    _dio.interceptors.add(DioInterceptor());
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

  logout() {
    shared_prefs.removeUserFromPrefs();
  }

  _handleError(DioException e) {
    throw Exception(e.response?.data['message']);
  }
}

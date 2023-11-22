import 'package:dio/dio.dart';

class DioInterceptor extends Interceptor {
  DioInterceptor();

  @override
  onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return handler.next(response);
  }
}

import 'package:afisha_admin_panel/db/login_db.dart';
import 'package:dio/dio.dart';

Dio addInterceptor(Dio dio) {
  dio.interceptors.add(LogInterceptor(
    request: true,
    responseBody: true,
  ));
  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      options.headers['Authorization'] = 'Bearer ${LoginDb.getToken()}';
      return handler.next(options);
    },
  ));
  return dio;
}

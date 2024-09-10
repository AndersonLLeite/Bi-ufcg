import 'package:dio/dio.dart';
import 'interceptor/auth_interceptor.dart';

class CustomDio {
  final Dio dio;
  final _authInterceptor = AuthInterceptor();

  CustomDio()
      : dio = Dio(BaseOptions(
          baseUrl: 'https://pre.ufcg.edu.br:8443/',
          connectTimeout: const Duration(milliseconds: 5000),
          receiveTimeout: const Duration(milliseconds: 60000),
        )) {
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      requestHeader: true,
    ));
  }

  CustomDio auth() {
    if (!dio.interceptors.contains(_authInterceptor)) {
      dio.interceptors.add(_authInterceptor);
    }
    return this;
  }

  CustomDio unAuth() {
    dio.interceptors.remove(_authInterceptor);
    return this;
  }
}

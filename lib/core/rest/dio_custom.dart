import 'package:dio/dio.dart';

class CustomDio {
  final Dio dio;

  CustomDio()
      : dio = Dio(BaseOptions(
          baseUrl: 'https://backend-bi-ufcg.onrender.com',
          connectTimeout: const Duration(milliseconds: 55000),
          receiveTimeout: const Duration(milliseconds: 60000),
        )) {
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      requestHeader: true,
    ));
  }
}

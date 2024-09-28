import 'package:dio/dio.dart';

class CustomDio {
  final Dio dio;

  CustomDio()
      : dio = Dio(BaseOptions(
          baseUrl: 'https://eureca.sti.ufcg.edu.br/das/v2',
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

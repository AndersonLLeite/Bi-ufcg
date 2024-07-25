import 'package:dio/dio.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../ui/global/global_context.dart';

class AuthInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final sp = await SharedPreferences.getInstance();
    final accessToken = sp.getString('accessToken');
    if (accessToken != null) {
      options.headers['Authentication-Token'] = accessToken;
    } else {
      // Se não há token, pode lançar uma exceção ou lidar de outra forma
      return handler.reject(DioException(
        requestOptions: options,
        error: 'Token de autenticação não encontrado.',
        type: DioExceptionType.cancel,
      ));
    }

    handler.next(options); // Continue com a requisição
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      Injector.get<GlobalContext>().loginExpire();
    } else {
      handler.next(err);
    }
  }
}

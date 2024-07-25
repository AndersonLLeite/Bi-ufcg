import 'dart:developer';

import 'package:dio/dio.dart';

import '../../core/exceptions/repository_exception.dart';
import '../../core/exceptions/unauthorized_exception.dart';
import '../../core/rest/dio_custom.dart';
import './auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final CustomDio dio;

  AuthRepositoryImpl({required this.dio});

  @override
  Future<String> login(
      {required String username, required String password}) async {
    try {
      final result = await dio.dio.post('/as_scao/as/tokens', data: {
        'credentials': {
          'username': username,
          'password': password,
        }
      });

      final accessToken = result.data['token'];
      if (accessToken == null) {
        throw UnauthorizedException(
            message: 'Usuário não autorizado a realizar essa ação!');
      }

      return accessToken;
    } on DioException catch (e, s) {
      log('Erro ao realizar login', error: e, stackTrace: s);
      if (e.response?.statusCode == 401) {
        throw UnauthorizedException(
            message: 'Usuário não autorizado a realizar essa ação!');
      }

      throw RepositoryException(message: 'Erro ao realizar o login');
    }
  }

  @override
  Future<void> logout() {
    throw UnimplementedError();
  }
}

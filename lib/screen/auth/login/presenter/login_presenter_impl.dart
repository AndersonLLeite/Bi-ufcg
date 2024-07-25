import 'dart:developer';
import 'package:bi_ufcg/repositories/auth/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/exceptions/unauthorized_exception.dart';
import '../../../../../service/login/login_service.dart';
import '../view/login_view.dart';
import './login_presenter.dart';

class LoginPresenterImpl implements LoginPresenter {
  final LoginService loginService;
  final AuthRepository authRepository;
  late final LoginView _view;

  LoginPresenterImpl({
    required this.loginService,
    required this.authRepository,
  });

  @override
  Future<void> login(String username, String password) async {
    try {
      await loginService.execute(username: username, password: password);
      _view.success();
    } on UnauthorizedException {
      _view.error('Usuário ou senha inválidos');
    } catch (e, s) {
      log('Erro ao realizar login', error: e, stackTrace: s);
      _view.error('Erro ao realizar login');
    }
  }

  @override
  set view(LoginView view) => _view = view;
}

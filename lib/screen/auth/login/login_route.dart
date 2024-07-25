import 'package:bi_ufcg/repositories/auth/auth_repository.dart';
import 'package:bi_ufcg/repositories/auth/auth_repository_impl.dart';
import 'package:bi_ufcg/screen/auth/login/presenter/login_presenter.dart';
import 'package:bi_ufcg/screen/auth/login/presenter/login_presenter_impl.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_getit/flutter_getit.dart';

import '../../../../service/login/login_service.dart';
import '../../../../service/login/login_service_impl.dart';
import 'login_page.dart';

class LoginRoute extends FlutterGetItPageRoute {
  const LoginRoute({super.key});

  @override
  List<Bind<Object>> get bindings => [
        Bind.lazySingleton<AuthRepository>((i) => AuthRepositoryImpl(dio: i())),
        Bind.lazySingleton<LoginService>(
          (i) => LoginServiceImpl(authRepository: i()),
        ),
        Bind.lazySingleton<LoginPresenter>(
          (i) => LoginPresenterImpl(loginService: i(), authRepository: i()),
        ),
      ];

  @override
  WidgetBuilder get page => (context) => LoginPage(
        presenter: context.get(),
      );
}

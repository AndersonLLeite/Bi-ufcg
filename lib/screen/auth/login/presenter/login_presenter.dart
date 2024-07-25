import 'package:bi_ufcg/core/mvp/biufcg_presenter.dart';

import '../view/login_view.dart';

abstract class LoginPresenter extends BiUfcgPresenter<LoginView> {
  Future<void> login(String email, String password);
}

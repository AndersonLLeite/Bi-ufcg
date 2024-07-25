import 'package:bi_ufcg/core/mvp/biufcg_presenter.dart';

abstract class SplashPresenter extends BiUfcgPresenter {
  Future<void> checkLogin();
}

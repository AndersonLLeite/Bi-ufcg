import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/ui/helpers/loader.dart';
import '../splash_page.dart';
import './splash_view.dart';

abstract class SplashViewImpl extends State<SplashPage>
    with Loader<SplashPage>
    implements SplashView {
  @override
  void initState() {
    widget.presenter.view = this;
    super.initState();
  }

  @override
  void logged(bool isLogged) async {
    hideLoader();
    if (isLogged) {
      SharedPreferences sp = await SharedPreferences.getInstance();
      String role = sp.getString('role') ?? '';
      if (role == 'ROLE_STUDENT') {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/home', (route) => false);
        //TODO mudar o caminho para quando o professor for logado
      } else if (role == 'ROLE_TEACHER') {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/teacher-home', (route) => false);
      } else if (role == 'ROLE_ADMIN') {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/admin-home', (route) => false);
      } else {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/auth/login', (route) => false);
      }
    } else {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/auth/login', (route) => false);
    }
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../../repositories/auth/auth_repository.dart';
import '../styles/colors_app.dart';
import 'global_context.dart';

class GlobalContextImpl implements GlobalContext {
  GlobalKey<NavigatorState> navigatorKey;
  final AuthRepository authRepository;

  GlobalContextImpl({
    required this.navigatorKey,
    required this.authRepository,
  });

  @override
  Future<void> loginExpire() async {
    final sp = await SharedPreferences.getInstance();
    await sp.clear();

    showTopSnackBar(
      navigatorKey.currentState!.context as OverlayState,
      CustomSnackBar.info(
        message: 'Sua sessão expirou, faça login novamente',
        backgroundColor: ColorsApp.instance.primary,
      ),
    );
    navigatorKey.currentState!
        .pushNamedAndRemoveUntil('/auth/login', (route) => false);
  }
}

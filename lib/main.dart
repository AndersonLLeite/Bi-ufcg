import 'package:bi_ufcg/repositories/auth/auth_repository.dart';
import 'package:bi_ufcg/repositories/auth/auth_repository_impl.dart';
import 'package:bi_ufcg/screen/auth/login/login_route.dart';
import 'package:bi_ufcg/screen/home/home_page.dart';
import 'package:bi_ufcg/screen/home/home_route.dart';
import 'package:bi_ufcg/screen/splash/view/splash_route.dart';
import 'package:bi_ufcg/widget_tree.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

import 'core/config/env/env.dart';
import 'core/rest/dio_custom.dart';
import 'resource/app_colors.dart';

void main() async {
  await Env.i.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return FlutterGetItApplicationBinding(
      bindingsBuilder: () => [
        Bind.lazySingleton<CustomDio>((i) => CustomDio()),
        Bind.lazySingleton<AuthRepository>((i) => AuthRepositoryImpl(dio: i())),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Admin Panel',
          theme: ThemeData(
              scaffoldBackgroundColor: AppColors.purpleDark,
              primarySwatch: Colors.blue,
              canvasColor: AppColors.purpleLight),
          routes: {
            '/': (_) => const SplashRoute(),
            '/login': (context) => const LoginRoute(),
            '/home': (context) => const HomeRoute(),
          }),
    );
  }
}

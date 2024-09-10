import 'package:bi_ufcg/core/ui/styles/colors_app.dart';
import 'package:bi_ufcg/service/data/data.dart';
import 'package:bi_ufcg/repositories/auth/auth_repository.dart';
import 'package:bi_ufcg/repositories/auth/auth_repository_impl.dart';
import 'package:bi_ufcg/screen/auth/login/login_route.dart';
import 'package:bi_ufcg/screen/home/home_route.dart';
import 'package:bi_ufcg/screen/splash/view/splash_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:provider/provider.dart';

import 'core/rest/dio_custom.dart';

void main() async {
  //await Env.i.load();
  runApp(
    ChangeNotifierProvider(
      create: (context) => Data(),
      child: const MyApp(),
    ),
  );
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
          title: 'BI UFCG',
          theme: ThemeData(
              scaffoldBackgroundColor: context.colors.secondary,
              primarySwatch: Colors.blue,
              canvasColor: context.colors.primary),
          routes: {
            '/': (_) => const SplashRoute(),
            '/login': (context) => const LoginRoute(),
            '/home': (context) => const HomeRoute(),
          }),
    );
  }
}

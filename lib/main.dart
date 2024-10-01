import 'package:bi_ufcg/shared/ui/styles/colors_app.dart';
import 'package:bi_ufcg/features/splash/splash_page.dart';
import 'package:bi_ufcg/service/data_service/data.dart';

import 'package:bi_ufcg/features/home/home_route.dart';
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
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'BI UFCG',
          theme: ThemeData(
              scaffoldBackgroundColor: context.colors.secondary,
              primarySwatch: Colors.blue,
              canvasColor: context.colors.primary),
          routes: {
            '/': (_) => const SplashPage(),
            '/home': (context) => const HomeRoute(),
          }),
    );
  }
}

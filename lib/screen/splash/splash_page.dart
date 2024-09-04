import 'package:bi_ufcg/screen/splash/presenter/splash_presenter.dart';
import 'package:bi_ufcg/screen/splash/view/splash_view_impl.dart';
import 'package:flutter/material.dart';

import '../../core/ui/styles/colors_app.dart';
import '../../core/ui/styles/text_styles.dart';

class SplashPage extends StatefulWidget {
  final SplashPresenter presenter;

  const SplashPage({
    Key? key,
    required this.presenter,
  }) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends SplashViewImpl {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/ufcgLogo.png',
                  width: 200,
                ),
                SizedBox(height: 20),
                Text(
                  'BIUFCG',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  child: Text(
                    'Entrar',
                    style: TextStyles.instance.buttonTitle,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

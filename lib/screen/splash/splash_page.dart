import 'package:bi_ufcg/core/ui/styles/colors_app.dart';
import 'package:bi_ufcg/screen/splash/presenter/splash_presenter.dart';
import 'package:bi_ufcg/screen/splash/view/splash_view_impl.dart';
import 'package:flutter/material.dart';

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
    // Obtendo a largura da tela
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [context.colors.primary, context.colors.secondary],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Ajusta o tamanho das imagens de acordo com a largura da tela
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/ufcgLogo.png',
                          width: screenWidth * 0.12, // 15% da largura da tela
                        ),
                        SizedBox(
                            width:
                                screenWidth * 0.02), // Espaçamento proporcional
                        Image.asset(
                          'assets/images/logo1-eureca.png',
                          width: screenWidth * 0.12,
                        ),
                        SizedBox(width: screenWidth * 0.02),
                        Image.asset(
                          'assets/images/logo2-eureca.png',
                          width: screenWidth * 0.12,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Bem-vindo ao BIUFCG',
                      style: context.textStyles.title.copyWith(
                        fontSize: 30,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text('“A verdade libertará você”.',
                        style: context.textStyles.subtitle),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: context.colors.tertiary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                      ),
                      child:
                          Text('Entrar', style: context.textStyles.buttonTitle),
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

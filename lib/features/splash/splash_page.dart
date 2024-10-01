import 'package:bi_ufcg/shared/ui/styles/colors_app.dart';
import 'package:flutter/material.dart';

import '../../shared/ui/styles/text_styles.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [context.colors.primary, context.colors.secondary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Container(
            width: screenWidth * 0.4, // Define o tamanho do quadrado central
            padding: const EdgeInsets.all(20), // Espaçamento interno
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20), // Bordas arredondadas
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Adapta a altura ao conteúdo
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      'assets/images/escudo-ufcg.png',
                      width: screenWidth * 0.16,
                    ),
                    Image.asset(
                      'assets/images/eureca-logo.png',
                      width: screenWidth * 0.16,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  'Bem-vindo ao BI UFCG',
                  style: context.textStyles.title.copyWith(
                    fontSize: 26, // Ajuste no tamanho da fonte
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(0.8),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  '“A verdade libertará você”.',
                  style: context.textStyles.subtitle.copyWith(
                    fontSize: 16, // Ajuste no subtítulo
                    fontStyle: FontStyle.italic,
                    color: Colors.black.withOpacity(0.6),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.colors.tertiary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 12,
                    ),
                  ),
                  child: Text(
                    'Acessar',
                    style: context.textStyles.buttonTitle.copyWith(
                      fontSize: 18, // Maior destaque no botão
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/home');
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

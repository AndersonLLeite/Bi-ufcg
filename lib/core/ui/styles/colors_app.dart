import 'package:flutter/material.dart';

class ColorsApp {
  static ColorsApp? _instance;
  // Avoid self isntance
  ColorsApp._();
  static ColorsApp get instance {
    _instance ??= ColorsApp._();
    return _instance!;
  }

  // Definição de cores já existente
  //Color get purpleLight => Color(0XFF1e224c);
  // Color get primary => const Color(0XFF0d193e);
  // Color get secondary => const Color(0XFF1e224c);
//#00205B
  Color get primary => const Color(0XFF00205B);
  //#1A4E8A
  Color get secondary => const Color(0XFF1A4E8A);
  //#3D87CB
  Color get tertiary => const Color(0XFF3D87CB);
  //HEX #00BCE1
  Color get quaternary => const Color(0XFF00BCE1);
  // #F6FAFC
  Color get quinary => const Color(0XFFF6FAFC);
  //#4B4F54
  Color get senary => const Color(0XFF4B4F54);

  Color get appBarColor => primary;
  Color get panelColor => primary;
  Color get titleSectioColor => secondary;
  Color get chartCardColor => secondary;
  Color get distribuitionCardColor => primary;

  Color get orange => const Color(0XFFec8d2f);
  Color get red => const Color(0XFFf44336);

  Color get maleColor => quaternary;
  Color get femaleColor => const Color.fromARGB(255, 255, 0, 170);

  Color get activeColor => const Color(0xFF4CAF50);
  Color get inactiveColor => const Color(0xFFf44336);
  Color get graduatedColor => const Color(0xFFff9800);

  Color get chartIconSelectedColor => quaternary;
  Color get menuIconSelectedColor => quaternary;
  Color get chartIconUnselectedColor => quinary;
  Color get chartTitleColor => quinary;
  Color get chartSubtitleColor => Colors.white70;
  Color get titleColor => quinary;
  Color get subtitleColor => Colors.white70;
  Color get drawerItemColor => Colors.white;
  Color get textButtonAppBarSelectedColor => Colors.white;
  Color get textButtonAppBarUnselectedColor => Colors.white70;
  Color get drawerBackgroundColor => primary;
  Color get titleInfoColor => Colors.black;

  // Lista de cores para os elementos do gráfico
  static const List<Color> chartColors = [
    Color.fromARGB(255, 255, 0, 170),
    Color(0xFF2196F3),

    Color(0xFF3BFF49),
    Color(0xFFFFA500),

    Color(0xFF6E1BFF),
    Color.fromARGB(179, 5, 5, 5),
    Color(0xFF8B4513),

    Color(0xFFE80054),
    Color(0xFF50E4FF),
    // Brown
    Color(0xFF00FF7F), // Spring Green
    // Orange
    Color(0xFFFF00FF), // Magenta
  ];

  // Método para acessar as cores dinamicamente
  static Color getColorForIndex(int index) {
    return chartColors[index % chartColors.length];
  }
}

extension ColorAppExtensions on BuildContext {
  ColorsApp get colors => ColorsApp.instance;
}

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
  Color get primary => Color(0XFF0d193e);
  Color get secondary => Color(0XFF1e224c);

  Color get appBarColor => Color(0XFF0d193e);
  Color get panelColor => Color(0XFF0d193e);
  Color get titleSectioColor => Color(0xFF1e224c);
  Color get chartCardColor => Color(0xFF1e224c);
  Color get distribuitionCardColor => Color(0XFF0d193e);

  Color get orange => Color(0XFFec8d2f);
  Color get red => Color(0XFFf44336);

  Color get maleColor => Color(0xFF2196F3);
  Color get femaleColor => Color.fromARGB(255, 255, 0, 170);

  Color get activeColor => Color(0xFF4CAF50);
  Color get inactiveColor => Color(0xFFf44336);
  Color get graduatedColor => Color(0xFFff9800);

  Color get chartIconSelectedColor => Color(0xFF2196F3);
  Color get menuIconSelectedColor => Color(0xFF2196F3);
  Color get chartIconUnselectedColor => Colors.white;
  Color get chartTitleColor => Colors.white;
  Color get chartSubtitleColor => Colors.white70;
  Color get titleColor => Colors.white;
  Color get subtitleColor => Colors.white70;
  Color get drawerItemColor => Colors.white;

  // Lista de cores para os elementos do gráfico
  static const List<Color> chartColors = [
    Color(0xFF2196F3),
    Color.fromARGB(255, 255, 0, 170),
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

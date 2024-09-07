// import 'package:flutter/material.dart';

// class ColorsApp {
//   static ColorsApp? _instance;
//   // Avoid self isntance
//   ColorsApp._();
//   static ColorsApp get instance {
//     _instance ??= ColorsApp._();
//     return _instance!;
//   }

//   // Definição de cores já existente
//   static const Color purpleLight = Color(0XFF1e224c);
//   static const Color purpleDark = Color(0XFF0d193e);
//   static const Color orange = Color(0XFFec8d2f);
//   static const Color red = Color(0XFFf44336);
//   static const Color primary = contentColorCyan;
//   static const Color menuBackground = Color(0xFF090912);
//   static const Color itemsBackground = Color(0xFF1B2339);
//   static const Color pageBackground = Color(0xFF282E45);
//   static const Color mainTextColor1 = Colors.white;
//   static const Color mainTextColor2 = Colors.white70;
//   static const Color mainTextColor3 = Colors.white38;
//   static const Color mainGridLineColor = Colors.white10;
//   static const Color borderColor = Colors.white54;
//   static const Color gridLinesColor = Color(0x11FFFFFF);

//   static const Color contentColorBlack = Colors.black;
//   static const Color contentColorWhite = Colors.white;
//   static const Color contentColorBlue = Color(0xFF2196F3);
//   static const Color contentColorYellow = Color(0xFFFFC300);
//   static const Color contentColorOrange = Color(0xFFFF683B);
//   static const Color contentColorGreen = Color(0xFF3BFF49);
//   static const Color contentColorPurple = Color(0xFF6E1BFF);
//   static const Color contentColorPink = Color(0xFFFF3AF2);
//   static const Color contentColorRed = Color(0xFFE80054);
//   static const Color contentColorCyan = Color(0xFF50E4FF);

//   static const Color maleColor = Color(0xFF2196F3);
//   static const Color femaleColor = Color.fromARGB(255, 255, 0, 170);

//   static const Color chartIconSelectedColor = Color(0xFF2196F3);
//   static const Color chartIconUnselectedColor = Colors.white;
//   static const Color chartTitleColor = Colors.white;
//   static const Color chartSubtitleColor = Colors.white70;
//   static const Color titleColor = Colors.white;
//   static const Color subtitleColor = Colors.white70;

//   // Lista de cores para os elementos do gráfico
//   static const List<Color> chartColors = [
//     contentColorBlue,
//     contentColorYellow,
//     contentColorOrange,
//     contentColorGreen,
//     contentColorPurple,
//     contentColorPink,
//     contentColorRed,
//     contentColorCyan,
//     Color(0xFF8B4513), // Brown
//     Color(0xFF00FF7F), // Spring Green
//     Color(0xFFFFA500), // Orange
//     Color(0xFFFF00FF), // Magenta
//   ];

//   // Método para acessar as cores dinamicamente
//   static Color getColorForIndex(int index) {
//     return chartColors[index % chartColors.length];
//   }
// }

// extension ColorsExtensions on BuildContext {
//   ColorsApp get colors => ColorsApp.instance;
// }

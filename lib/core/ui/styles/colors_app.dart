import 'package:flutter/material.dart';

class ColorsApp {
  static ColorsApp? _instance;
  // Avoid self isntance
  ColorsApp._();
  static ColorsApp get instance {
    _instance ??= ColorsApp._();
    return _instance!;
  }

  Color get primary => const Color(0xFF252E76);
  Color get secondary => const Color(0xFF6662FC);

  Color get greyProfile => const Color(0xFFC3AECA);
  Color get gold => const Color(0xFFffd700);
  Color get marromgold => const Color(0xFF8b7500);
  Color get silver => const Color(0xFFc0c0c0);
  Color get silverGray => const Color(0xFF808080);
  Color get bronze => const Color(0xFFcd7f32);
  Color get saddleBrown => const Color(0xFF8b4513);
  Color get yelow => const Color(0xFFFDCE50);
  Color get grey => const Color(0xFFCCCCCC);
  Color get greyDart => const Color(0xFF999999);

  Color get primaryColorFromCalendar => const Color(0xFF252E76);
  Color get secondaryColorFromCalendar => const Color(0xFFB61409);
  Color get tertiaryColorFromCalendar => const Color(0xFF39C01F);
  Color get quaternaryColorFromCalendar => const Color(0xFFDFDB17);
  Color get quinaryColorFromCalendar => const Color(0xFFDB1578);
  Color get senaryColorFromCalendar => const Color(0xFF1578DB);
  Color get septenaryColorFromCalendar => const Color(0xFFD415DB);
  Color get octonaryColorFromCalendar => const Color(0xFFDB8F15);
  Color get nonaryColorFromCalendar => const Color(0xFF15DBD4);
  Color get denaryColorFromCalendar => const Color(0xFF2F5F3C);
  //assistant colors
  Color get mainFontColor => const Color.fromRGBO(19, 61, 95, 1);
  Color get firstSuggestionBoxColor => const Color.fromRGBO(165, 231, 244, 1);
  Color get secondSuggestionBoxColor => const Color.fromRGBO(157, 202, 235, 1);
  Color get thirdSuggestionBoxColor => const Color.fromRGBO(162, 238, 239, 1);
  Color get assistantCircleColor => const Color.fromRGBO(209, 243, 249, 1);
  Color get borderColor => const Color.fromRGBO(200, 200, 200, 1);
  Color get blackColor => Colors.black;
  Color get whiteColor => Colors.white;
}

extension ColorAppExtensions on BuildContext {
  ColorsApp get colors => ColorsApp.instance;
}

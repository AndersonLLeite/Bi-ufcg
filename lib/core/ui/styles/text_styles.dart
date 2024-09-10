import 'package:flutter/material.dart';

import 'colors_app.dart';

class TextStyles {
  static TextStyles? _instance;
  // Avoid self isntance
  TextStyles._();
  static TextStyles get instance {
    _instance ??= TextStyles._();
    return _instance!;
  }

  String get primaryFont => 'MerryweatherSans';
  String get secondaryFont => 'BeVietnamPro';

  //primary font
  TextStyle get textPrimaryFontRegular =>
      TextStyle(fontWeight: FontWeight.normal, fontFamily: primaryFont);

  TextStyle get buttonTitle =>
      TextStyle(fontWeight: FontWeight.bold, fontFamily: primaryFont);

  TextStyle get title => TextStyle(
      fontWeight: FontWeight.bold,
      fontFamily: primaryFont,
      color: ColorsApp.instance.titleColor,
      fontSize: 16);

  TextStyle get subtitle => TextStyle(
      fontWeight: FontWeight.normal,
      fontFamily: secondaryFont,
      color: ColorsApp.instance.subtitleColor,
      fontSize: 14);

  TextStyle get textTitleChart => TextStyle(
      fontWeight: FontWeight.bold,
      fontFamily: primaryFont,
      color: ColorsApp.instance.chartTitleColor,
      fontSize: 16);

  TextStyle get textSubtitleChart => TextStyle(
      fontWeight: FontWeight.normal,
      fontFamily: secondaryFont,
      color: ColorsApp.instance.chartSubtitleColor,
      fontSize: 14);

  TextStyle get textDrawerCourseItems => TextStyle(
      fontWeight: FontWeight.bold,
      fontFamily: primaryFont,
      color: ColorsApp.instance.drawerItemColor,
      fontSize: 11);

  TextStyle get textDrawerTermsItems => TextStyle(
      fontWeight: FontWeight.bold,
      fontFamily: primaryFont,
      color: ColorsApp.instance.drawerItemColor,
      fontSize: 16);
}

extension TextStylesExtensions on BuildContext {
  TextStyles get textStyles => TextStyles.instance;
}

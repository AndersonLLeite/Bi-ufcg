import 'package:bi_ufcg/resource/app_colors.dart';
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

  String get primaryFont => 'Poppins';
  String get secondaryFont => 'MPlus1P';

  //primary font
  TextStyle get textPrimaryFontRegular =>
      TextStyle(fontWeight: FontWeight.normal, fontFamily: primaryFont);

  TextStyle get buttonTitle =>
      TextStyle(fontWeight: FontWeight.bold, fontFamily: primaryFont);

  TextStyle get textTitleChart => TextStyle(
      fontWeight: FontWeight.bold,
      fontFamily: primaryFont,
      color: AppColors.chartTitleColor,
      fontSize: 18);

  TextStyle get textSubtitleChart => TextStyle(
      fontWeight: FontWeight.normal,
      fontFamily: primaryFont,
      color: AppColors.chartSubtitleColor,
      fontSize: 16);
}

extension TextStylesExtensions on BuildContext {
  TextStyles get textStyles => TextStyles.instance;
}

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

  TextStyle get numberPodium => TextStyle(
      fontWeight: FontWeight.bold,
      fontFamily: primaryFont,
      fontSize: 70,
      color: Colors.white);

  TextStyle get textPrimaryFontMedium =>
      TextStyle(fontWeight: FontWeight.w500, fontFamily: primaryFont);

  TextStyle get numberListTileClassification => TextStyle(
        fontWeight: FontWeight.w500,
        fontFamily: primaryFont,
      );

  TextStyle get textPointsClassification => TextStyle(
        fontWeight: FontWeight.bold,
        fontFamily: primaryFont,
      );

  TextStyle get textPrimaryFontSemiBold =>
      TextStyle(fontWeight: FontWeight.w600, fontFamily: primaryFont);

  TextStyle get textPrimaryFontBold =>
      TextStyle(fontWeight: FontWeight.bold, fontFamily: primaryFont);

  TextStyle get textTitleSplashPage => TextStyle(
      fontWeight: FontWeight.bold, fontFamily: primaryFont, fontSize: 35);

  TextStyle get textCardInfo => TextStyle(
      fontWeight: FontWeight.bold,
      fontFamily: primaryFont,
      color: Colors.black,
      fontSize: 22);

  TextStyle get textSubtitleSplashPage => TextStyle(
        fontFamily: primaryFont,
        fontSize: 15,
      );

  TextStyle get textPrimaryFontExtraBold =>
      TextStyle(fontWeight: FontWeight.w800, fontFamily: primaryFont);

  //secondary font

  TextStyle get textSecondaryFontRegular =>
      TextStyle(fontWeight: FontWeight.normal, fontFamily: secondaryFont);

  TextStyle get textSecondaryFontMedium =>
      TextStyle(fontWeight: FontWeight.w600, fontFamily: secondaryFont);

  TextStyle get textSecondaryFontBold =>
      TextStyle(fontWeight: FontWeight.bold, fontFamily: secondaryFont);

  TextStyle get textSecondaryFontExtraBold =>
      TextStyle(fontWeight: FontWeight.w800, fontFamily: secondaryFont);

  TextStyle get labelTextField => textSecondaryFontRegular.copyWith(
        color: ColorsApp.instance.greyDart,
      );

  TextStyle get textSecondaryFontExtraBoldPrimaryColor =>
      textSecondaryFontExtraBold.copyWith(color: ColorsApp.instance.primary);

  TextStyle get titleWhite =>
      textPrimaryFontBold.copyWith(color: Colors.white, fontSize: 22);

  TextStyle get titleBlack =>
      textPrimaryFontBold.copyWith(color: Colors.black, fontSize: 22);
  TextStyle get profilePrimary =>
      textPrimaryFontBold.copyWith(color: Colors.white, fontSize: 15);
  TextStyle get profileSecondary => textPrimaryFontBold.copyWith(
      color: ColorsApp.instance.greyProfile, fontSize: 15);
  TextStyle get profileName => textPrimaryFontBold.copyWith(
      color: ColorsApp.instance.greyProfile, fontSize: 15);
}

extension TextStylesExtensions on BuildContext {
  TextStyles get textStyles => TextStyles.instance;
}

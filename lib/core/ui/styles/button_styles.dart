import 'package:bi_ufcg/core/ui/styles/text_styles.dart';
import 'package:flutter/material.dart';

import 'colors_app.dart';

class ButtonStyles {
  static ButtonStyles? _instance;
  // Avoid self isntance
  ButtonStyles._();
  static ButtonStyles get instance {
    _instance ??= ButtonStyles._();
    return _instance!;
  }

  // ButtonStyle get rimaryButton => ElevatedButton.styleFrom(
  //     backgroundColor: ColorsApp.instance.primary,
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
  //     textStyle: TextStyles.instance.textSecondaryFontExtraBold
  //         .copyWith(fontSize: 14));

  // ButtonStyle get yellowOutLineButton => OutlinedButton.styleFrom(
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
  //     side: BorderSide(color: ColorsApp.instance.primary),
  //     textStyle: TextStyles.instance.textSecondaryFontExtraBold
  //         .copyWith(fontSize: 14));

  ButtonStyle get primaryButton => ElevatedButton.styleFrom(
      backgroundColor: ColorsApp.instance.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      textStyle: TextStyles.instance.textSecondaryFontExtraBold
          .copyWith(fontSize: 14));
  ButtonStyle get secondaryButton => ElevatedButton.styleFrom(
      backgroundColor: ColorsApp.instance.secondary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      textStyle: TextStyles.instance.textSecondaryFontExtraBold
          .copyWith(fontSize: 14));

  ButtonStyle get primaryOutLineButton => OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      side: BorderSide(color: ColorsApp.instance.primary),
      textStyle: TextStyles.instance.textSecondaryFontExtraBold
          .copyWith(fontSize: 14));
}

extension ButtonStylesExtensions on BuildContext {
  ButtonStyles get buttonStyles => ButtonStyles.instance;
}

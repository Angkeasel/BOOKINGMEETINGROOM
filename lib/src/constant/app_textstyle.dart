import 'package:flutter/material.dart';
import 'package:meetroombooking/src/constant/app_size.dart';

final textFieldLabelStyle = TextStyle(
  fontSize: 18,
  fontVariations: [
    FontWeight.w500.getVariant,
  ],
);

final textFieldTextStyle = TextStyle(
  fontSize: 18,
  fontVariations: [
    FontWeight.w500.getVariant,
  ],
);

extension ThemeExtension on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;

  TextStyle get bodyLarge => textTheme.bodyLarge!;
  TextStyle get bodyMedium => textTheme.bodyMedium!;
  TextStyle get bodySmall => textTheme.bodySmall!;

  TextStyle get displayLarge => textTheme.displayLarge!;
  TextStyle get displayMedium => textTheme.displayMedium!;
  TextStyle get displaySmall => textTheme.displaySmall!;

  TextStyle get labelLarge => textTheme.labelLarge!;
  TextStyle get labelMedium => textTheme.labelMedium!;
  TextStyle get labelSmall => textTheme.labelSmall!;

  TextStyle get headlineLarge => textTheme.headlineLarge!;
  TextStyle get headlineMedium => textTheme.headlineMedium!;
  TextStyle get headlineSmall => textTheme.headlineSmall!;

  TextStyle get titleLarge => textTheme.titleLarge!;
  TextStyle get titleMedium => textTheme.titleMedium!;
  TextStyle get titleSmall => textTheme.titleSmall!;

  TextStyle get appBarTextStyle => titleLarge.copyWith(
        color: Colors.white,
        fontFamily: 'KantumruyPro',
        fontVariations: [
          FontWeight.w500.getVariant,
        ],
      );

  // TextStyle get subtitle1 => textTheme.subtitle1!;
  // TextStyle get subtitle2 => textTheme.subtitle2!;

  // TextStyle get bodyText1 => textTheme.bodyText1!;
  // TextStyle get bodyText2 => textTheme.bodyText2!;

  // TextStyle get caption => textTheme.caption!;
  // TextStyle get button => textTheme.button!;

  // TextStyle get overline => textTheme.overline!;
}

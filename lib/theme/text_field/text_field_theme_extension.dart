import 'package:flutter/material.dart';

import '../text/text_theme_extension.dart';

class TextFieldThemeExtension extends ThemeExtension<TextFieldThemeExtension> {
  final Color labelTextColor;
  final Color hintTextColor;
  final Color outlineColor;
  final Color textColor;

  static final light = TextFieldThemeExtension(
    labelTextColor: Color(0xFFAEAEAE),
    hintTextColor: Color(0xFFA3A3A3),
    outlineColor: Color(0xFFAEAEAE),
    textColor: TextThemeExtension.light.mainText,
  );

  static final dark = light;

  const TextFieldThemeExtension({
    required this.labelTextColor,
    required this.hintTextColor,
    required this.outlineColor,
    required this.textColor,
  });

  @override
  ThemeExtension<TextFieldThemeExtension> copyWith({
    Color? labelTextColor,
    Color? hintTextColor,
    Color? outlineColor,
    Color? textColor,
  }) =>
      TextFieldThemeExtension(
        labelTextColor: labelTextColor ?? this.labelTextColor,
        hintTextColor: hintTextColor ?? this.hintTextColor,
        outlineColor: outlineColor ?? this.outlineColor,
        textColor: textColor ?? this.textColor,
      );

  @override
  ThemeExtension<TextFieldThemeExtension> lerp(
    covariant ThemeExtension<TextFieldThemeExtension>? other,
    double t,
  ) =>
      this;
}

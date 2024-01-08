import 'package:flutter/material.dart';

class TextThemeExtension extends ThemeExtension<TextThemeExtension> {
  final Color mainText;
  final Color minorText;

  static const light = TextThemeExtension(
    mainText: Color(0xFF4F4F4F),
    minorText: Color(0xFFC6C6C6),
  );

  static const dark = light;

  const TextThemeExtension({
    required this.mainText,
    required this.minorText,
  });

  @override
  ThemeExtension<TextThemeExtension> copyWith({
    Color? mainText,
    Color? minorText,
  }) =>
      TextThemeExtension(
        mainText: mainText ?? this.mainText,
        minorText: minorText ?? this.minorText,
      );

  @override
  ThemeExtension<TextThemeExtension> lerp(
    covariant ThemeExtension<TextThemeExtension>? other,
    double t,
  ) =>
      this;
}

import 'package:flutter/material.dart';

class TextThemeExtension extends ThemeExtension<TextThemeExtension> {
  final Color mainText;
  final Color minorText;
  final Color highlightedYellow;

  static const light = TextThemeExtension(
    mainText: Color(0xFF4F4F4F),
    minorText: Color(0xFFC6C6C6),
    highlightedYellow: Color(0xFFFFC000),
  );

  static const dark = light;

  const TextThemeExtension({
    required this.mainText,
    required this.minorText,
    required this.highlightedYellow,
  });

  @override
  ThemeExtension<TextThemeExtension> copyWith({
    Color? mainText,
    Color? minorText,
    Color? highlightedYellow,
  }) =>
      TextThemeExtension(
        mainText: mainText ?? this.mainText,
        minorText: minorText ?? this.minorText,
        highlightedYellow: highlightedYellow ?? this.highlightedYellow,
      );

  @override
  ThemeExtension<TextThemeExtension> lerp(
    covariant ThemeExtension<TextThemeExtension>? other,
    double t,
  ) =>
      this;
}

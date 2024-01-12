import 'package:flutter/material.dart';

class LineDividerThemeExtension
    extends ThemeExtension<LineDividerThemeExtension> {
  final Color backgroundColor;

  static const light = LineDividerThemeExtension(
    backgroundColor: Color(0xFFD1D1D1),
  );

  static const dark = light;

  const LineDividerThemeExtension({
    required this.backgroundColor,
  });

  @override
  ThemeExtension<LineDividerThemeExtension> copyWith({
    Color? backgroundColor,
  }) =>
      LineDividerThemeExtension(
        backgroundColor: backgroundColor ?? this.backgroundColor,
      );

  @override
  ThemeExtension<LineDividerThemeExtension> lerp(
    covariant ThemeExtension<LineDividerThemeExtension>? other,
    double t,
  ) =>
      this;
}

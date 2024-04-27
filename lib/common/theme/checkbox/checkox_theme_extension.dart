import 'package:flutter/material.dart';

class CheckboxThemeExtension extends ThemeExtension<CheckboxThemeExtension> {
  final Color background;
  final Color activeBackground;

  static const light = CheckboxThemeExtension(
    activeBackground: Colors.white,
    background: Color(0xFFFFCFA3),
  );

  static const dark = light;

  const CheckboxThemeExtension({
    required this.background,
    required this.activeBackground,
  });

  @override
  ThemeExtension<CheckboxThemeExtension> copyWith({
    Color? background,
    Color? activeBackground,
  }) =>
      CheckboxThemeExtension(
        background: background ?? this.background,
        activeBackground: activeBackground ?? this.activeBackground,
      );

  @override
  ThemeExtension<CheckboxThemeExtension> lerp(
    covariant ThemeExtension<CheckboxThemeExtension>? other,
    double t,
  ) =>
      this;
}

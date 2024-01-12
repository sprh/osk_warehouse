import 'package:flutter/material.dart';

class IconButtonThemeExtension
    extends ThemeExtension<IconButtonThemeExtension> {
  final Color background;

  static const light = IconButtonThemeExtension();

  static const dark = light;

  const IconButtonThemeExtension({
    this.background = Colors.transparent,
  });

  @override
  ThemeExtension<IconButtonThemeExtension> copyWith({
    Color? background,
  }) =>
      IconButtonThemeExtension(
        background: background ?? this.background,
      );

  @override
  ThemeExtension<IconButtonThemeExtension> lerp(
    covariant ThemeExtension<IconButtonThemeExtension>? other,
    double t,
  ) =>
      this;
}

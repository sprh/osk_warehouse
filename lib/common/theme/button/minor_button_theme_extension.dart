import 'package:flutter/material.dart';

import 'button_theme_extension.dart';

final class MinorButtonThemeExtension
    extends ThemeExtension<MinorButtonThemeExtension>
    implements ButtonThemeExtension {
  static const light = MinorButtonThemeExtension(
    backgroundColor: Color(0xFFFFFFFF),
    disabledTextColor: Color(0xFF787D80),
    borderColor: Color(0xFF515B60),
  );

  static const dark = light;

  @override
  final Color backgroundColor;
  @override
  final Color disabledTextColor;
  @override
  final Color borderColor;

  const MinorButtonThemeExtension({
    required this.backgroundColor,
    required this.disabledTextColor,
    required this.borderColor,
  });

  @override
  ThemeExtension<MinorButtonThemeExtension> lerp(
    covariant ThemeExtension<MinorButtonThemeExtension>? other,
    double t,
  ) =>
      this;

  @override
  ThemeExtension<MinorButtonThemeExtension> copyWith({
    Color? backgroundColor,
    Color? disabledBackgroundColor,
    Color? disabledTextColor,
    Color? borderColor,
  }) =>
      MinorButtonThemeExtension(
        backgroundColor: backgroundColor ?? this.backgroundColor,
        disabledTextColor: disabledTextColor ?? this.disabledTextColor,
        borderColor: borderColor ?? this.borderColor,
      );
}
